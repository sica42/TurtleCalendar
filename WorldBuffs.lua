TurtleCalendar = TurtleCalendar or {}

---@class TurtleCalendar
local m = TurtleCalendar

if m.WorldBuffs then return end

---@class WorldBuffs
---@field get_buffs fun( faction: string): string
---@field clear_expired_timers fun()

local M = {}

M.bosses = {
	O = "Onyxia",
	N = "Nefarian",
}

M.yell_triggers = {
	A = {
		O = m.T[ 'YELL_TRIGGER_ALLIANCE_ONYXIA' ],
		N = m.T[ 'YELL_TRIGGER_ALLIANCE_NEFARIAN' ],
	},
	H = {
		O = m.T[ 'YELL_TRIGGER_HORDE_ONYXIA' ],
		N = m.T[ 'YELL_TRIGGER_HORDE_NEFARIAN' ],
	},
}

function M.new( wb_timers )
	local channel_name = "LFT"
	local timer_strs = {}
	local is_on_kalimdor
	local next_publish_at
	local me
	local BUFF_CD_HOURS = 2
	local version = 10610

	---@class WBFrame: Frame
	local frame = CreateFrame( 'Frame', nil, UIParent )
	frame.start_time = GetTime()

	frame:RegisterEvent( "CHAT_MSG_CHANNEL" )
	frame:RegisterEvent( "PLAYER_ENTERING_WORLD" )
	frame:RegisterEvent( "CHAT_MSG_MONSTER_YELL" )

	-- Identity function
	local function identity( x )
		return x
	end

	-- Decode the provided timer string into a timer table.
	local function decode( timerStr )
		local _, _, faction, boss, hStr, mStr, witness = string.find( timerStr, '(.*)%-(.*)%-(.*)%-(.*)%-(.*)' )
		return faction, boss, tonumber( hStr ), tonumber( mStr ), witness
	end

	-- Encode the provided timer as a string that can be shared with other addon users.
	local function encode( faction, boss, h, m, witness )
		if not faction or not boss or not h or not m or not witness then return end
		return string.format( '%s-%s-%.2d-%.2d-%s', faction, boss, h, m, witness )
	end

	-- Encode all of our timers as strings, separated by semicolon.
	local function encode_all()
		local timersStr
		for _, timers in pairs( wb_timers ) do
			for _, timer in pairs( timers ) do
				local faction, boss, h, min, witness = timer.faction, timer.boss, timer.h, timer.m, timer.witness
				timersStr = (timersStr and timersStr .. ';' or '') .. encode( faction, boss, h, min, witness )
			end
		end
		return timersStr
	end

	-- Given an NPC's yell message, check if it's one of the triggers for a buff being dropped.
	-- If yes, return the boss and faction. Otherwise, return nil.
	local function parse_monster_yell( yellMsg )
		for faction, bossTriggers in pairs( M.yell_triggers ) do
			for boss, yellTrigger in pairs( bossTriggers ) do
				local found = string.find( yellMsg, yellTrigger )
				if found then
					return boss, faction
				end
			end
		end
	end

	local function get_server_time()
		local h, min = GetGameTime()

		-- TurtleWoW has continent timezones, so we need to normalize the server time if player is on Kalimdor
		if is_on_kalimdor then
			h = mod( h + 12, 24 )
		end

		return h, min
	end

	-- Get a time table representing a certain number of hours from now (server time).
	local function hours_from_now( hours )
		local h, min = get_server_time()
		h = mod( h + hours, 24 )
		return h, min
	end

	-- Check if condition applies to any of our timers.
	local function some_timer( fn )
		if not wb_timers then return false end

		for _, timers in pairs( wb_timers ) do
			for _, timer in pairs( timers ) do
				if fn( timer ) then return true end
			end
		end
		return false
	end

	-- Check if we currently have any timers stored.
	local function has_timers()
		return some_timer( identity )
	end

	-- Invoke fn for each timer we have stored currently.
	local function for_each_timer( fn )
		if not wb_timers then return end

		for _, timers in pairs( wb_timers ) do
			for _, timer in pairs( timers ) do
				fn( timer )
			end
		end
	end


	-- Convert a time table to string in Hh Mm format, e.g. 1h 52m.
	local function to_string( h, min )
		if not h and not min then return m.T[ "N/A" ] end
		return (h > 0 and h .. 'h ' or '') .. min .. 'm'
	end

	-- Convert a time (duration) table to a number of minutes.
	local function to_minutes( h, min )
		return h * 60 + min
	end

	-- Convert a number of minutes to a time table representing the same duration.
	local function to_time( minutes )
		local min = mod( minutes, 60 )
		local h = (minutes - min) / 60
		return h, min
	end

	-- Generate a time table representing the duration from now until the provided
	-- timer will run out.
	local function get_time_left( h, min )
		local sh, sm = get_server_time()

		if sh > h and h < BUFF_CD_HOURS then
			-- now is before and deadline is after midnight. Let's just fix the diff
			-- calculation by adding 24 hours to the deadline time.
			h = h + 24
		end

		local diff = to_minutes( h, min ) - to_minutes( sh, sm )

		local isExpired = diff < 0
		local isInvalid = diff > BUFF_CD_HOURS * 60
		if isExpired or isInvalid then return end

		return to_time( diff )
	end

	local function is_valid( h, min, acceptedAt )
		local now = time()
		local twoHours = 2 * 60 * 60

		-- Mark timer as invalid if we accepted/stored it more than 2 hours ago. This prevents an
		-- issue that's due to the timers containing only the time, not the date. Without this, if
		-- you log off at e.g. 7 pm with 1 hour left on Ony buff and then log back in the next day
		-- at 7 pm, the addon will just resume the old timer because it doesn't know it's from
		-- the day before.
		if not acceptedAt or acceptedAt > now or acceptedAt < now - twoHours then
			return false
		end

		return get_time_left( h, min ) ~= nil
	end

	-- Clear all local timers, even valid ones.
	local function clear_all_timers()
		wb_timers = {
			A = {},
			H = {},
		}
	end

	-- Remove the provided timer from our local timer store.
	local function clear_timer( timer )
		wb_timers[ timer.faction ][ timer.boss ] = nil
	end

	-- Clear all invalid timers from our local timer store.
	local function clear_expired_timers()
		-- Initialize timers if they somehow haven't been initialized yet
		if not wb_timers then clear_all_timers() end

		for_each_timer( function( timer )
			if not is_valid( timer.h, timer.m, timer.acceptedAt ) then
				clear_timer( timer )
			end
		end )
	end

	-- Get our current timer for the provided faction and boss.
	local function get_timer( faction, boss )
		return wb_timers[ faction ][ boss ]
	end

	local function set_timer( faction, boss, h, min, witness, received_from )
		wb_timers[ faction ][ boss ] = {
			faction = faction,
			boss = boss,
			h = h,
			m = min,
			witness = witness,
			receivedFrom = received_from,
			acceptedAt = time(),
		}
	end

	-- Check if the provided timer should be accepted and stored locally.
	local function should_accept_new_timer( faction, boss, h, min, witness, received_from )
		local currentTimer = get_timer( faction, boss )

		-- Never accept invalid or expired timers
		if not is_valid( h, min, time() ) then return false end

		-- Always accept if we currently don't have a timer for this buff
		if not currentTimer then return true end

		-- Always accept if current timer is expired or invalid
		if not is_valid( currentTimer.h, currentTimer.m, currentTimer.acceptedAt ) then return true end

		-- Always accept new timers that we witnessed ourselves
		if witness == me then return true end

		-- Never accept other peoples' timers if we currently have a timer that we witnessed ourselves
		if currentTimer.witness == me then return false end

		-- Otherwise, only accept if the new timer came from a direct witness and our current one didn't
		return received_from == witness and currentTimer.receivedFrom ~= currentTimer.witness
	end

	-- Get the color that should be used for a timer, based on how confident we are in it.
	local function get_timer_color( witness, receivedFrom )
		if witness == me then return m.colors.green end
		if receivedFrom == witness then return m.colors.orange end
		return m.colors.red
	end

	-- Check if we should publish our local data.
	local function should_publish()
		return next_publish_at and time() > next_publish_at
	end

	local function reset_publish_delay()
		local min, max = 10, 60

		-- (Re)set our own publish delay to a random number of seconds.
		local delay = math.random( min, max )
		next_publish_at = time() + delay
	end

	local function publish_timers()
		-- Always clear all expired timers (again) right before publishing to make sure we never share
		-- outdated timers.
		clear_expired_timers()

		if not has_timers() or UnitLevel( 'player' ) < 5 then
			return
		end

		local pwb_channel = GetChannelName( channel_name )
		if pwb_channel ~= 0 then
			SendChatMessage( "PWB:" .. version .. ':' .. encode_all(), 'CHANNEL', nil, pwb_channel )
		end
	end

	local function publish_all()
		publish_timers()
		reset_publish_delay()
	end

	local function on_event()
		if event == "PLAYER_ENTERING_WORLD" then
			me = UnitName( "player" )

			is_on_kalimdor = GetCurrentMapContinent() == 1

			-- If we don't have any timers or we still have timers in a deprecated format, clear/initialize them first.
			if not has_timers() then
				clear_all_timers()
			end

			-- Set an initial publish delay
    	reset_publish_delay()
		elseif event == "CHAT_MSG_CHANNEL" and arg2 ~= UnitName( "player" ) then
			local _, _, source = string.find( arg4, "(%d+)%." )
			local channelName

			if source then
				_, channelName = GetChannelName( source )
			end

			if channelName == channel_name then
				local _, _, addon_name, remote_version, msg = string.find( arg1, '(.*)%:(.*)%:(.*)' )
				if addon_name == "PWB" then
					if tonumber( remote_version ) < 10104 then
						return
					end

					timer_strs[ 1 ], timer_strs[ 2 ], timer_strs[ 3 ], timer_strs[ 4 ] = m.str_split( msg, ';' )

					for _, timer_str in next, timer_strs do
						local faction, boss, h, min, witness = decode( timer_str )
						if not faction or not boss or not h or not min or not witness then return end

						local received_from = arg2
						if should_accept_new_timer( faction, boss, h, min, witness, received_from ) then
							set_timer( faction, boss, h, min, witness, received_from )
						end
					end
				end
			end
		elseif event == 'CHAT_MSG_MONSTER_YELL' then
			local boss, faction = parse_monster_yell( arg1 )
			if boss and faction then
				local h, min = hours_from_now( 2 )
				set_timer( faction, boss, h, min, me, me )
			end
		end
	end

	local function on_update()
		if (this.tick or 1) > GetTime() then return else this.tick = GetTime() + 1 end

		clear_expired_timers()

		if should_publish() then
			publish_all()
		end

		local delay = 5
		if this.start_time and GetTime() * 1000 >= (this.start_time + delay) * 1000 then
			local is_in_channel = false
			local channels = { GetChannelList() }
			this.start_time = nil

			for _, channel in next, channels do
				if channel == channel_name then
					is_in_channel = true
					break
				end
			end

			if not is_in_channel then
				JoinChannelByName( channel_name )
			end
		end
	end

	local function get_buffs( faction )
		local str
		for _, boss in pairs( { "O", "N" } ) do
			local timer = wb_timers and wb_timers[ faction ] and wb_timers[ faction ][ boss ]
			local time_str = m.colors.grey .. m.T[ "N/A" ]
			if timer then
				local h, min = get_time_left( timer.h, timer.m )
				time_str = get_timer_color( timer.witness, timer.receivedFrom ) .. to_string( h, min )
			end
			local boss_color = faction == 'A' and m.colors.alliance or m.colors.horde
			str = str and str .. ", " or ""
			str = str .. boss_color .. m.T[ M.bosses[ boss ] ] .. ": " .. time_str .. "|r"
		end

		return str
	end

	frame:SetScript( "OnUpdate", on_update )
	frame:SetScript( "OnEvent", on_event )

	---@type WorldBuffs
	return {
		get_buffs = get_buffs,
		clear_expired_timers = clear_expired_timers,
	}
end

m.WorldBuffs = M
return M
