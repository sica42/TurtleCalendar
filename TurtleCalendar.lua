---@class TurtleCalendar
TurtleCalendar = TurtleCalendar or {}

---@class TurtleCalendar
local m = TurtleCalendar

BINDING_HEADER_TURTLECALENDAR_HEADER = "TurtleCalendar"
BINDING_NAME_TURTLECALENDAR_OPENMENU = m.T[ "Toggle the calendar" ]

TurtleCalendar.name = "TurtleCalendar"
TurtleCalendar.events = {}
TurtleCalendar.debug_enabled = false

TurtleCalendar.colors = {
	tag = "|cff4e8a00",
	pizza = "|cffa050ff",

	alliance = "|cff0070dd",
	horde = "|cffc41e3a",
	white = "|cffffffff",
	grey = "|cffaaaaaa",
	green = "|cff00ff98",
	orange = "|cffff7c0a",
	red = "|cffc41e3a",
	yellow = "|cffdddd00"
}

TurtleCalendar.images = {
	[ "bwl" ] = { image = "Interface\\AddOns\\TurtleCalendar\\assets\\bwl.blp", height = 276 / 512 },
	[ "ony" ] = { image = "Interface\\AddOns\\TurtleCalendar\\assets\\ony.blp", height = 276 / 512 },
	[ "kara" ] = { image = "Interface\\AddOns\\TurtleCalendar\\assets\\kara.blp", height = 276 / 512 },
	[ "zg" ] = { image = "Interface\\AddOns\\TurtleCalendar\\assets\\zg.blp", height = 276 / 512 },
	[ "eom" ] = { image = "Interface\\AddOns\\TurtleCalendar\\assets\\eom.blp", height = 276 / 512 },
	[ "instances" ] = { image = "Interface\\AddOns\\TurtleCalendar\\assets\\instances.blp", height = 276 / 512 },
	[ "instances2" ] = { image = "Interface\\AddOns\\TurtleCalendar\\assets\\instances2.blp", height = 208 / 256 },
	[ "Thunder Bluff" ] = { image = "Interface\\AddOns\\TurtleCalendar\\assets\\dmf_tb.blp", height = 229 / 256 },
	[ "Goldshire" ] = { image = "Interface\\AddOns\\TurtleCalendar\\assets\\dmf_gs.blp", height = 229 / 256 },
	[ "bg_av" ] = { image = "Interface\\AddOns\\TurtleCalendar\\assets\\bg_av.blp", height = 208 / 256 },
	[ "bg_wg" ] = { image = "Interface\\AddOns\\TurtleCalendar\\assets\\bg_wg.blp", height = 208 / 256 },
	[ "bg_arathi" ] = { image = "Interface\\AddOns\\TurtleCalendar\\assets\\bg_arathi.blp", height = 208 / 256 },
	[ "bg_bra" ] = { image = "Interface\\AddOns\\TurtleCalendar\\assets\\bg_bra.blp", height = 208 / 256 },
	[ "bg_sgv" ] = { image = "Interface\\AddOns\\TurtleCalendar\\assets\\bg_sgv.blp", height = 208 / 256 },
	[ "eom_grilek" ] = { image = "Interface\\AddOns\\TurtleCalendar\\assets\\eom_grilek.blp", height = 1 },
	[ "eom_hazzarah" ] = { image = "Interface\\AddOns\\TurtleCalendar\\assets\\eom_hazzarah.blp", height = 1 },
	[ "eom_renataki" ] = { image = "Interface\\AddOns\\TurtleCalendar\\assets\\eom_renataki.blp", height = 1 },
	[ "eom_wushoolay" ] = { image = "Interface\\AddOns\\TurtleCalendar\\assets\\eom_wushoolay.blp", height = 1 }
}

TurtleCalendar.bgs = {
	[ 1 ] = { id = "av", name = m.T[ "Alterac Valley" ] },
	[ 2 ] = { id = "wg", name = m.T[ "Warsong Gulch" ] },
	[ 3 ] = { id = "arathi", name = m.T[ "Arathi Basin" ] },
	[ 4 ] = { id = "bra", name = m.T[ "Blood Ring Arena" ] },
	[ 5 ] = { id = "sgv", name = m.T[ "Sunnyglade Valley" ] }
}

TurtleCalendar.eom = {
	[ 1 ] = { id = "grilek", name = m.T[ "Gri'lek" ] },
	[ 2 ] = { id = "hazzarah", name = m.T[ "Hazza'rah" ] },
	[ 3 ] = { id = "renataki", name = m.T[ "Renataki" ] },
	[ 4 ] = { id = "wushoolay", name = m.T[ "Wushoolay" ] }
}

TurtleCalendar.raids = {
	[ m.T[ "Molten Core" ] ] = "raid40",
	[ m.T[ "Blackwing Lair" ] ] = "raid40",
	[ m.T[ "Ahn'Qiraj Temple" ] ] = "raid40",
	[ m.T[ "Naxxramas" ] ] = "raid40",
	[ m.T[ "Emerald Sanctum" ] ] = "raid40",
	[ m.T[ "Onyxia's Lair" ] ] = "ony",
	[ m.T[ "Lower Karazhan Halls" ] ] = "kara",
	[ m.T[ "Zul'Gurub" ] ] = "zg",
	[ m.T[ "Ruins of Ahn'Qiraj" ] ] = "zg",
}

TurtleCalendar.quests = {
	[ "Call to Arms: Cleansing the Corruption" ] = {},
	[ "Call to Arms: Dungeon Delving" ] = {},
	[ "Call to Arms: Molten Assault" ] = {}
}

function TurtleCalendar:init()
	self.utc_offset = m.get_utc_offset()
	self.timers = {
		[ "Nordanaar" ] = {
			[ "raid40" ] = { interval = 7, anchor = m.time_utc( { year = 2025, month = 9, day = 3, hour = 3 } ) },
			[ "ony" ] = { interval = 5, anchor = m.time_utc( { year = 2025, month = 9, day = 1, hour = 3 } ) },
			[ "kara" ] = { interval = 5, anchor = m.time_utc( { year = 2025, month = 9, day = 2, hour = 3 } ) },
			[ "zg" ] = { interval = 3, anchor = m.time_utc( { year = 2025, month = 8, day = 30, hour = 3 } ) },
			[ "eom" ] = { interval = 14, anchor = m.time_utc( { year = 2025, month = 4, day = 7, hour = 23 } ) },
			[ "bg" ] = { interval = 1, anchor = m.time_utc( { year = 2025, month = 9, day = 0, hour = 23 } ) },
			[ "dmf" ] = { interval = 7, anchor = m.time_utc( { year = 2025, month = 8, day = 30, hour = 23 } ) }
		},
		[ "Tel'Abim" ] = {
			[ "raid40" ] = { interval = 7, anchor = m.time_utc( { year = 2025, month = 9, day = 4, hour = 3 } ) },
			[ "ony" ] = { interval = 5, anchor = m.time_utc( { year = 2025, month = 9, day = 0, hour = 3 } ) },
			[ "kara" ] = { interval = 5, anchor = m.time_utc( { year = 2025, month = 9, day = 0, hour = 3 } ) },
			[ "zg" ] = { interval = 3, anchor = m.time_utc( { year = 2025, month = 8, day = 28, hour = 3 } ) },
			[ "eom" ] = { interval = 14, anchor = m.time_utc( { year = 2025, month = 4, day = 7, hour = 23 } ) },
			[ "bg" ] = { interval = 1, anchor = m.time_utc( { year = 2025, month = 9, day = 0, hour = 23 } ) },
			[ "dmf" ] = { interval = 7, anchor = m.time_utc( { year = 2025, month = 8, day = 30, hour = 23 } ) }
		},
		[ "Ambershire" ] = {
			[ "raid40" ] = { interval = 7, anchor = m.time_utc( { year = 2025, month = 9, day = 3, hour = 3 } ) },
			[ "ony" ] = { interval = 5, anchor = m.time_utc( { year = 2025, month = 9, day = 1, hour = 3 } ) },
			[ "kara" ] = { interval = 5, anchor = m.time_utc( { year = 2025, month = 9, day = 2, hour = 3 } ) },
			[ "zg" ] = { interval = 3, anchor = m.time_utc( { year = 2025, month = 8, day = 30, hour = 3 } ) },
			[ "eom" ] = { interval = 14, anchor = m.time_utc( { year = 2025, month = 4, day = 7, hour = 23 } ) },
			[ "bg" ] = { interval = 1, anchor = m.time_utc( { year = 2025, month = 9, day = 0, hour = 23 } ) },
			[ "dmf" ] = { interval = 7, anchor = m.time_utc( { year = 2025, month = 8, day = 30, hour = 23 } ) }
		},
	}

	self.frame = CreateFrame( "Frame" )
	self.frame:SetScript( "OnEvent", function()
		if m.events[ event ] then
			m.events[ event ]()
		end
	end )

	for k, _ in pairs( m.events ) do
		m.frame:RegisterEvent( k )
	end
end

function TurtleCalendar.events.PLAYER_LOGIN()
	-- Initialize DB
	TurtleCalendarOptions = TurtleCalendarOptions or {}
	m.db = TurtleCalendarOptions
	m.db.instances = m.db.instances or {}
	m.db.last_instance = m.db.last_instance or ""
	m.db.date_format = m.db.date_format or "%d.%m.%Y"
	if m.db.show_timers == nil then m.db.show_timers = true end
	if m.db.show_dates == nil then m.db.show_dates = false end
	if m.db.condensed_timers == nil then m.db.condensed_timers = false end
	if m.db.show_world_buffs == nil then m.db.show_world_buffs = true end
	if m.db.show_sw_buffs == nil then m.db.show_sw_buffs = true end
	if m.db.show_og_buffs == nil then m.db.show_og_buffs = true end
	if m.db.show_weekly_quests_alert == nil then m.db.show_weekly_quests_alert = true end
	m.db.quests = m.db.quests or {}
	m.db.minimap_icon = m.db.minimap_icon or { hide = false }
	m.db.boxes = m.db.boxes or {
		[ 1 ] = { "raid40", true },
		[ 2 ] = { "ony", true },
		[ 3 ] = { "kara", true },
		[ 4 ] = { "zg", true },
		[ 5 ] = { "eom", true },
		[ 6 ] = { "bg", true },
		[ 7 ] = { "dmf", true },
		[ 8 ] = { "instances", true }
	}

	m.frame_padding = 15
	m.delta = 1
	m.first = true
	m.realm = GetRealmName()
	m.api = getfenv()
	m.player = UnitName( "player" )

	---@class MinimapIcon
	m.minimap_icon = m.MinimapIcon.new()

	---@class WorldBuffs
	m.world_buffs = m.WorldBuffs.new()

	m.font_header = CreateFont( "TCFontHeader" )
	m.font_header:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\AoboshiOne.ttf", 25, "" )
	m.font_medium = CreateFont( "TCFontMedium" )
	m.font_medium:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\AoboshiOne.ttf", 12, "" )
	m.font_normal = CreateFont( "TCFontNormal" )
	m.font_normal:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\AoboshiOne.ttf", 11, "" )
	m.font_small = CreateFont( "TCFontSmall" )
	m.font_small:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\AoboshiOne.ttf", 10, "" )
	m.font_tiny = CreateFont( "TCFontTiny" )
	m.font_tiny:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\AoboshiOne.ttf", 9, "" )
	m.font_digit_label = CreateFont( "TCFontDigitLabel" )
	m.font_digit_label:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\Monaco.ttf", 8, "" )

	local locale = GetLocale() or "enUS"
	if locale == "zhCN" or locale == "zhTW" then
		m.font_header:SetFont( "Fonts\\ARHei.ttf", 25, "" )
		m.font_medium:SetFont( "Fonts\\ARHei.ttf", 12, "" )
		m.font_normal:SetFont( "Fonts\\ARHei.ttf", 11, "" )
		m.font_small:SetFont( "Fonts\\ARHei.ttf", 10, "" )
		m.font_tiny:SetFont( "Fonts\\ARHei.ttf", 9, "" )
		m.font_digit_label:SetFont( "Fonts\\ARHei.ttf", 8, "" )
	end

	m.api[ "SLASH_TurtleCalendar1" ] = "/tc"
	m.api[ "SLASH_TurtleCalendar2" ] = "/TurtleCalendar"
	SlashCmdList[ "TurtleCalendar" ] = m.slashHandler

	if m.api.IsAddOnLoaded( "pfUI" ) and m.api.pfUI and m.api.pfUI.api and m.api.pfUI.env and m.api.pfUI.env.C then
		m.pfui_skin_enabled = true
		m.api.pfUI:RegisterSkin( "TurtleCalendar", "vanilla", function()
			if m.api.pfUI.env.C.disabled and m.api.pfUI.env.C.disabled[ "skin_TurtleCalendar" ] == "1" then
				m.pfui_skin_enabled = false
			end
		end )
	end

	m.version = GetAddOnMetadata( m.name, "Version" )
	m.info( string.format( "(v%s) Loaded", m.version ) )

	-- Fallback to Nordanaar if unknown realm.
	if m.realm ~= "Nordanaar" and m.realm ~= "Tel'Abim" and m.realm ~= "Ambershire" then
		m.info( "Raid timers for " .. m.realm .. " not found, using Nordanaar timers." )
		m.realm = "Nordanaar"
	end
end

function TurtleCalendar.events.PLAYER_ENTERING_WORLD()
	if m.first then
		m.first = false
		return
	end

	local timer = 0

	-- Wait 3 seconds for zone name to update before checking instance
	m.frame:SetScript( "OnUpdate", function()
		timer = timer + arg1
		if timer >= 3 then
			m.frame:SetScript( "OnUpdate", nil )
			m.check_instance()
		end
	end )
end

function TurtleCalendar.events.CHAT_MSG_SYSTEM()
	if arg1 and arg1 ~= "" then
		local _, _, zone = string.find( arg1, string.gsub( INSTANCE_RESET_SUCCESS, "%%s", "(.+)" ) )

		if zone then
			m.reset_instances()
			SendAddonMessage( "TurtleCalendar", "RESET:" .. zone, "PARTY" )
		end
	end
end

function TurtleCalendar.events.CHAT_MSG_ADDON()
	if arg1 == "TurtleCalendar" and arg4 ~= UnitName( "player" ) then
		local _, _, zone = string.find( arg2, "RESET:(.+)" )
		local msg = string.sub( string.format( INSTANCE_RESET_SUCCESS, zone ), 1, -2 ) .. " by " .. arg4 .. "."

		DEFAULT_CHAT_FRAME:AddMessage( msg, ChatTypeInfo[ "SYSTEM" ].r, ChatTypeInfo[ "SYSTEM" ].g, ChatTypeInfo[ "SYSTEM" ].b )
		m.reset_instances()
	end
end

function TurtleCalendar.events.UPDATE_INSTANCE_INFO()
	local savedInstances = GetNumSavedInstances()
	local instanceName, instanceID, instanceReset

	m.instances = {}
	if (savedInstances > 0) then
		for i = 1, savedInstances do
			instanceName, instanceID, instanceReset = GetSavedInstanceInfo( i )
			m.instances[ instanceName ] = {
				name = instanceName,
				id = instanceID,
				reset = instanceReset
			}
		end
	end
end

function TurtleCalendar.events.PLAYER_REGEN_DISABLED()
	if m.current_instance then
		m.debug( "Instance locked: " .. m.current_instance.name )
		table.insert( m.db.instances, m.current_instance )
		m.current_instance = nil
	end
end

function TurtleCalendar.events.ZONE_CHANGED_NEW_AREA()
	local zone = GetZoneText()
	if zone == "Stormwind City" or zone == "Orgrimmar" then
		m.check_quests()
	end
end

function TurtleCalendar.events.QUEST_LOG_UPDATE()
	local num = GetNumQuestLogEntries()

	for _, q in pairs( m.quests ) do
		q.found = false
	end

	for i = 1, num do
		local title, _, _, _, _, completed = GetQuestLogTitle( i )
		completed = completed and true or false
		if m.quests[ title ] then
			m.quests[ title ].found = true
			local quest = m.db.quests[ title ]
			if not quest or quest and (not quest.active or quest.completed ~= completed) then
				m.db.quests[ title ] = {
					active = not completed,
					timestamp = time(),
					completed = completed
				}
			end
		end
	end

	for k, q in pairs( m.quests ) do
		if not q.found then
			local quest = m.db.quests[ k ]
			if quest and not quest.completed then quest.active = false end
		end
	end
end

function TurtleCalendar.check_quests()
	if m.db.show_weekly_quests_alert then
		local do_warn = false
		for _, q in pairs( m.db.quests ) do
			local last_thu = m.get_last_thursday()
			if not q.active and not q.completed or (not q.active and q.completed and m.get_last_thursday( q.timestamp ) ~= last_thu) then
				do_warn = true
				break
			end
		end

		if do_warn then
			if RaidWarningFrame then
				RaidWarningFrame:AddMessage( "Weekly quests are available to pick up!", 1.0, 0.1, 0.2, 1.0, 8 )
				m.api.PlaySound( "RaidWarning" )
				m.api.PlaySound( "PVPTHROUGHQUEUE" )
			end
			m.info( "|cffff0000Weekly quests are available to pick up!|r" )
		end
	end
end

function TurtleCalendar.check_instance()
	local in_instance, instance_type = IsInInstance()
	local zone_name = GetRealZoneText()

	-- All Scarlet Monastey zones count as 1
	zone_name = string.gsub( zone_name, "(Scarlet Monastery).*", "%1" )

	m.clear_expired_instances()
	if in_instance and instance_type == "party" and m.db.last_instance ~= zone_name then
		local instance = m.find( zone_name, m.db.instances, "name" )

		if instance then
			-- Only set current_instance if existing one is locked by manual reset
			if instance.locked then
				m.current_instance = { name = zone_name, timestamp = time() }
			end
		else
			m.debug( "New instances: " .. zone_name )
			m.current_instance = { name = zone_name, timestamp = time() }
		end

		m.db.last_instance = zone_name
	else
		m.current_instance = nil
	end
end

function TurtleCalendar.clear_expired_instances()
	local now = time()
	local instances = {}
	for _, v in ipairs( m.db.instances ) do
		if v.timestamp then
			if (now - v.timestamp < 3600) then
				table.insert( instances, v )
			end
		end
	end

	m.db.instances = instances
	if next( instances ) == nil then
		m.db.last_instance = ""
	end
end

function TurtleCalendar.reset_instances()
	local found_unlocked
	for _, instance in ipairs( m.db.instances ) do
		if not instance.locked then
			found_unlocked = true
		end
		instance.locked = true
	end

	-- If you reset an instance without having engaged in combat
	if m.db.last_instance and not found_unlocked then
		table.insert( m.db.instances, { name = m.db.last_instance, timestamp = time(), locked = true } )
	end

	m.db.last_instance = ""
	m.current_instance = nil
end

function TurtleCalendar.create_digit( parent, unit, size )
	local height = size == 10 and 9 or 21
	local width = size == 10 and 15 or 32

	---@class DigitFrame: ScrollFrame
	local scroll_frame = CreateFrame( "ScrollFrame", nil, parent )
	scroll_frame:SetWidth( width )
	scroll_frame:SetHeight( height )

	local child_frame = CreateFrame( "Frame", nil, scroll_frame )
	child_frame:SetPoint( "TopLeft", scroll_frame, "TopLeft", 0, 0 )
	child_frame:SetWidth( width )
	child_frame:SetHeight( height )
	scroll_frame:SetScrollChild( child_frame )

	local digit = child_frame:CreateFontString( nil, "OVERLAY" )
	digit:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\Monaco.ttf", size, "" )
	digit:SetTextColor( 0.8, 0.8, 0.8, 1 )
	digit:SetPoint( "TopLeft", child_frame, "TopLeft", 0, 0 )

	local label = parent:CreateFontString( nil, "OVERLAY", "TCFontDigitLabel" )
	label:SetTextColor( 0.8, 0.8, 0.8, 1 )
	label:SetPoint( "TopLeft", scroll_frame, "BottomLeft", 0, -4 )
	label:SetText( unit )

	scroll_frame:SetScript( "OnHide", function()
		label:Hide()
	end )
	scroll_frame:SetScript( "OnShow", function()
		label:Show()
	end )

	scroll_frame.set_digit = function( value )
		local current = tonumber( digit:GetText() )
		if current ~= value then
			local fps = GetFramerate()
			scroll_frame.new_value = value
			scroll_frame:SetScript( "OnUpdate", function()
				local max_h = size
				local step = (size / 10) * (120 / fps)
				if scroll_frame.new_value then
					local _, _, _, _, top = child_frame:GetPoint()

					if scroll_frame.new_value >= 0 then
						child_frame:SetPoint( "TopLeft", scroll_frame, "TopLeft", 0, top - step )
						if top <= -max_h then
							digit:SetText( string.format( "%02d", scroll_frame.new_value ) )
							child_frame:SetPoint( "TopLeft", scroll_frame, "TopLeft", 0, max_h )
							scroll_frame.new_value = -1
						end
					elseif scroll_frame.new_value < 0 then
						child_frame:SetPoint( "TopLeft", scroll_frame, "TopLeft", 0, top - step )
						if top <= 0 then
							scroll_frame.new_value = nil
							child_frame:SetPoint( "TopLeft", scroll_frame, "TopLeft", 0, 0 )
							scroll_frame:SetScript( "OnUpdate", nil )
						end
					end
				end
			end )
		end
	end

	return scroll_frame
end

---@param parent Frame
---@param data table
---@return BoxFrame
function TurtleCalendar.create_box( parent, data )
	---@class BoxFrame: Frame
	local frame = CreateFrame( "Frame", nil, parent )
	frame:SetWidth( data.width )
	frame:SetHeight( data.height )
	frame:EnableMouse( true )
	frame:SetBackdrop( {
		bgFile = "Interface\\Buttons\\WHITE8X8",
		edgeFile = "Interface\\AddOns\\TurtleCalendar\\assets\\UI-Border.tga",
		tile = true,
		edgeSize = 16,
		tileSize = 32,
		insets = {
			left = 5,
			right = 5,
			top = 5,
			bottom = 5
		}
	} )
	frame:SetBackdropColor( 0, 0, 0, 1 )

	if data.id ~= "wbuffs" then
		local bg = frame:CreateTexture( nil, "ARTWORK" )
		bg:SetPoint( "TopLeft", frame, "TopLeft", 4, -4 )
		bg:SetPoint( "BottomRight", frame, "BottomRight", -4, 4 )
		bg:SetTexture( data.background.image )
		bg:SetTexCoord( 0, 1, 0, data.background.height )
		bg:SetVertexColor( 1, 1, 1, 0.5 )
		frame.bg = bg
	end

	if data.id == "eom" then
		local mob = frame:CreateTexture( nil, "OVERLAY" )
		mob:SetWidth( 220 )
		mob:SetHeight( 220 )
		mob:SetPoint( "Center", frame, "Center", 0, 0 )
		mob:SetTexture( m.images[ "eom_hazzarah" ].image )
		mob:SetVertexColor( 0.6, 0.6, 0.6, 1 )
		frame.mob = mob
	end

	local header = frame:CreateFontString( nil, "OVERLAY", "TCFontHeader" )
	header:SetPoint( "Center", frame, "Center", 0, 0 )
	header:SetPoint( "Top", frame, "Top", 0, -20 )
	header:SetText( data.header )
	frame.header = header

	if data.id == "instances" then
		for i = 1, 5 do
			local name = frame:CreateFontString( nil, "OVERLAY", "TCFontNormal" )
			name:SetPoint( "TopLeft", frame, "TopLeft", 10, -40 - (i * 20) )
			name:SetWidth( 135 )
			name:SetHeight( 15 )
			name:SetJustifyH( "Left" )
			frame[ "inst" .. i .. "_name" ] = name

			local time = frame:CreateFontString( nil, "OVERLAY" )
			time:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\Monaco.ttf", 11, "" )
			time:SetHeight( 15 )
			time:SetPoint( "TopLeft", frame, "TopRight", -55, -40 - (i * 20) )
			frame[ "inst" .. i .. "_time" ] = time
		end
	end

	local sub1 = frame:CreateFontString( nil, "OVERLAY", "TCFontNormal" )
	sub1:SetPoint( "Center", frame, "Center", 0, 0 )
	sub1:SetPoint( "Top", header, "Bottom", 0, -5 )
	sub1:SetText( data.sub1 or " " )
	frame.sub1 = sub1

	local sub2 = frame:CreateFontString( nil, "OVERLAY", "TCFontSmall" )
	sub2:SetTextColor( 0.8, 0.8, 0.8, 1 )
	sub2:SetPoint( "Center", frame, "Center", 0, 0 )
	sub2:SetPoint( "Top", sub1, "Bottom", 0, -5 )
	sub2:SetText( data.sub2 )
	frame.sub2 = sub2

	if data.id == "wbuffs" then
		local buff_frame = CreateFrame( "Frame", nil, frame )
		buff_frame:SetHeight( 15 )
		buff_frame:SetPoint( "Center", frame, "Center", 0, 0 )
		frame.buff_frame = buff_frame

		for i = 1, 5 do
			buff_frame[ "text_frame" .. i ] = CreateFrame( "Frame", nil, buff_frame )
			buff_frame[ "text_frame" .. i ]:SetHeight( 15 )
			buff_frame[ "text_frame" .. i ].index = i
			buff_frame[ "text_frame" .. i ].text = buff_frame[ "text_frame" .. i ]:CreateFontString( nil, "OVERLAY", "TCFontNormal" )
			buff_frame[ "text_frame" .. i ].text:SetPoint( "TopLeft", buff_frame[ "text_frame" .. i ], "TopLeft", 0, -2 )
			if i == 1 then
				buff_frame[ "text_frame" .. i ]:SetPoint( "Left", buff_frame, "Left", 0, 0 )
			else
				buff_frame[ "text_frame" .. i ]:SetPoint( "Left", buff_frame[ "text_frame" .. (i - 1) ], "Right", 0, 0 )
			end
			if i ~= 3 then
				buff_frame[ "text_frame" .. i ]:EnableMouse( true )
				buff_frame[ "text_frame" .. i ]:SetScript( "OnEnter", function()
					local faction = this.index < 3 and "A" or "H"
					local boss = mod( this.index - 1, 3 ) == 0 and "O" or "N"
					local timer = m.db.wb_timers and m.db.wb_timers[ faction ] and m.db.wb_timers[ faction ][ boss ]
					if not timer then return end

					GameTooltip:SetOwner( this, "ANCHOR_BOTTOMRIGHT" )
					local titleColor = faction == 'A' and m.colors.alliance or m.colors.horde
					GameTooltip:SetText( titleColor .. m.WorldBuffs.bosses[ boss ] .. ' Head' )
					local timerColor = m.world_buffs.get_timer_color( timer.witness, timer.receivedFrom )
					local h, min = m.world_buffs.get_time_left( timer.h, timer.m )
					GameTooltip:AddLine( m.colors.white .. 'Time left: ' .. timerColor .. m.world_buffs.to_string( h, min ) )
					local witness = timer.witness == m.player and 'YOU' or timer.witness
					GameTooltip:AddLine( m.colors.white .. 'Witness: ' .. m.colors.pizza .. witness )
					GameTooltip:Show()
				end )
				buff_frame[ "text_frame" .. i ]:SetScript( "OnLeave", function()
					GameTooltip:Hide()
				end )
			end
		end
		sub2:ClearAllPoints()
		sub2:SetPoint( "Right", frame, "Right", -10, 0 )
		sub2:SetPoint( "Top", frame, "Top", 0, -10 )
		sub2:SetFontObject( m.font_tiny )
	end

	if data.id ~= "instances" and data.id ~= "wbuffs" then
		local sub3 = frame:CreateFontString( nil, "OVERLAY", "TCFontSmall" )
		sub3:SetTextColor( 0.8, 0.8, 0.8, 1 )
		sub3:SetPoint( "Center", frame, "Center", 0, 0 )
		sub3:SetPoint( "Top", sub2, "Bottom", 0, -5 )
		frame.sub3 = sub3

		local inst_name = frame:CreateFontString( nil, "OVERLAY", "TCFontSmall" )
		inst_name:SetTextColor( 0.8, 0.8, 0.8, 1 )
		inst_name:SetPoint( "TopLeft", frame, "TopLeft", 30, -90 )
		inst_name:SetJustifyH( "Left" )
		frame.inst_name = inst_name

		local inst_id = frame:CreateFontString( nil, "OVERLAY", "TCFontSmall" )
		inst_id:SetTextColor( 0.8, 0.8, 0, 1 )
		inst_id:SetPoint( "TopRight", frame, "TopRight", -30, -90 )
		inst_id:SetJustifyH( "Right" )
		frame.inst_id = inst_id

		local time = CreateFrame( "Frame", nil, frame )
		time:SetWidth( 150 )
		time:SetHeight( 35 )
		time:SetPoint( "Center", frame, "Center", 0, 0 )
		time:SetPoint( "Bottom", frame, "Bottom", 0, 35 )
		frame.time = time

		frame.days = m.create_digit( time, m.T[ "days" ], 25 )
		frame.days:SetPoint( "TopLeft", time, "TopLeft", 0, 0 )

		frame.hours = m.create_digit( time, m.T[ "hours" ], 25 )
		frame.hours:SetPoint( "BottomLeft", frame.days, "BottomRight", 10, 0 )

		frame.min = m.create_digit( time, m.T[ "min" ], 25 )
		frame.min:SetPoint( "BottomLeft", frame.hours, "BottomRight", 10, 0 )

		frame.sec = m.create_digit( time, m.T[ "sec" ], 10 )
		frame.sec:SetPoint( "BottomLeft", frame.min, "BottomRight", 10, 0 )

		local date = frame:CreateFontString( nil, "OVERLAY" )
		date:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\Monaco.ttf", 12, "" )
		date:SetPoint( "Bottom", frame, "Bottom", 0, 15 )
		date:SetPoint( "Center", frame, "Center", 0, 0 )
		date:SetTextColor( 0.8, 0.8, 0.8, 1 )
		frame.date = date
	end

	if data.id == "bg" then
		frame.bg:SetPoint( "BottomRight", frame, "BottomRight", -4, 45 )
		frame.time:SetPoint( "Bottom", frame, "Bottom", 0, 65 )

		local next_bg = frame:CreateTexture( nil, "ARTWORK" )
		next_bg:SetPoint( "TopLeft", frame, "BottomLeft", 4, 43 )
		next_bg:SetPoint( "BottomRight", frame, "BottomRight", -4, 4 )
		next_bg:SetTexCoord( 0, 1, 0, data.background.height )
		next_bg:SetVertexColor( 1, 1, 1, 0.2 )
		frame.next_bg = next_bg

		local next_day = frame:CreateFontString( nil, "OVERLAY", "TCFontMedium" )
		next_day:SetPoint( "Center", frame, "Center", 0, 0 )
		next_day:SetPoint( "Bottom", frame, "Bottom", 0, 20 )
		frame.next_day = next_day
	end

	frame:SetScript( "OnMouseDown", m.popup_menu )

	if frame.bg then
		frame.alpha = 0.5
		frame:SetScript( "OnEnter", function()
			local a = frame.alpha
			frame:SetScript( "OnUpdate", function()
				a = a + 0.01
				frame.bg:SetVertexColor( 1, 1, 1, a )
				if a >= frame.alpha + 0.1 then
					frame:SetScript( "OnUpdate", nil )
				end
			end )
		end )

		frame:SetScript( "OnLeave", function()
			local a = frame.alpha + 0.1
			frame:SetScript( "OnUpdate", function()
				a = a - 0.01
				frame.bg:SetVertexColor( 1, 1, 1, a )
				if a <= frame.alpha then
					frame:SetScript( "OnUpdate", nil )
				end
			end )
		end )
	end

	frame.set_visibility = function( visible )
		frame.is_visible = visible
		if frame.is_visible then
			frame:Show()
		else
			frame:Hide()
		end
	end

	frame.is_visible = true
	frame.data = data
	return frame
end

function TurtleCalendar.create_frame()
	---@class TurtleCalendarFrame: Frame
	local frame = CreateFrame( "Frame", "TurtleCalendarPopup", UIParent )
	frame:SetFrameStrata( "DIALOG" )
	frame:SetWidth( 1070 )
	frame:SetHeight( 460 )
	frame:SetPoint( "Center", UIParent, "Center", 0, 100 )
	frame:SetBackdrop( {
		bgFile = "Interface\\Buttons\\WHITE8x8",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true,
		tileSize = 32,
		edgeSize = 32,
		insets = { left = 8, right = 8, top = 8, bottom = 8 }
	} )
	frame:SetBackdropColor( 0, 0, 0, 0.8 )
	frame:EnableMouse( true )
	frame:SetMovable( true )
	frame:SetResizable( true )
	frame:RegisterForDrag( "LeftButton" )
	frame:SetClampedToScreen( true )

	table.insert( UISpecialFrames, frame:GetName() )

	frame:SetScript( "OnMouseDown", m.popup_menu )
	frame:SetScript( "OnDragStart", function()
		this:StartMoving()
	end )

	frame:SetScript( "OnDragStop", function()
		this:StopMovingOrSizing()
		local point, _, relative_point, x, y = this:GetPoint()

		m.db.position = {
			point = point,
			relative_point = relative_point,
			x = x,
			y = y
		}
	end )

	frame:SetScript( "OnSizeChanged", m.on_resize )


	if m.db.position then
		local p = m.db.position
		frame:ClearAllPoints()
		frame:SetPoint( p.point, UIParent, p.relative_point, p.x, p.y )
	end

	-- Title bar
	---@class TitlebarFrame: Frame
	local title_bar = CreateFrame( "Frame", nil, frame )
	title_bar:SetPoint( "TopLeft", frame, "TopLeft", 11, -11 )
	title_bar:SetPoint( "BottomRight", frame, "TopRight", -11, -31 )
	title_bar:SetBackdrop( { bgFile = "Interface/Buttons/WHITE8x8" } )
	title_bar:SetBackdropColor( 0, 0, 0, 1 )
	frame.title_bar = title_bar

	local line1 = CreateFrame( "Frame", nil, title_bar )
	line1:SetPoint( "TopLeft", title_bar, "BottomLeft", 0, 2 )
	line1:SetPoint( "BottomRight", title_bar, "BottomRight", 0, 1 )
	line1:SetBackdrop( { bgFile = "Interface/Buttons/WHITE8x8" } )
	line1:SetBackdropColor( 0.6, 0.6, 0.6, 1 )
	title_bar.line1 = line1

	local line2 = CreateFrame( "Frame", nil, title_bar )
	line2:SetPoint( "TopLeft", title_bar, "BottomLeft", 0, 1 )
	line2:SetPoint( "BottomRight", title_bar, "BottomRight", 0, 0 )
	line2:SetBackdrop( { bgFile = "Interface/Buttons/WHITE8x8" } )
	line2:SetBackdropColor( 0.3, 0.3, 0.3, 1 )
	title_bar.line2 = line2

	local btn_close = CreateFrame( "Button", nil, title_bar, "UIPanelCloseButton" )
	btn_close:SetPoint( "TopRight", title_bar, "TopRight", 7, 7 )
	btn_close:SetScript( "OnClick", function()
		m.hide()
	end )
	title_bar.btn_close = btn_close

	local title = title_bar:CreateFontString( nil, "OVERLAY", "GameFontHighlight" )
	title:SetPoint( "Left", title_bar, "Left", 7, 1 )
	title:SetText( "Turtle Calendar v" .. m.version )

	-- Main content
	local content = CreateFrame( "Frame", nil, frame )
	content:SetPoint( "TopLeft", frame, "TopLeft", 15, -35 )
	content:SetPoint( "BottomRight", frame, "BottomRight", 0, 0 )
	frame.content = content

	local bw, bh = 204, 222
	m.boxes = {}

	m.boxes.wbuffs = m.create_box( content, {
		id = "wbuffs",
		name = "World buffs",
		background = m.images[ "wb_stormwind" ],
		sub1 = "",
		sub2 = m.T[ "Powered by " ] .. m.colors.pizza .. "Pizza" .. m.colors.white .. "WorldBuffs|r",
		width = 413,
		height = 30
	} )
	m.boxes.wbuffs:SetPoint( "TopLeft", content, "TopLeft", 0, 0 )
	m.boxes.wbuffs:SetPoint( "Right", content, "Right", -15, 0 )

	m.boxes.raid40 = m.create_box( content, {
		id = "raid40",
		name = m.T[ "Raid" ] .. " 40",
		background = m.images[ "bwl" ],
		header = m.T[ "Raid" ] .. " 40",
		sub1 = "MC/BWL/AQ40/Naxx/ES/Kara",
		sub2 = string.format( m.T[ "Resets every %d days" ], 7 ),
		width = bw,
		height = bh
	} )
	m.boxes.raid40:SetPoint( "TopLeft", content, "TopLeft", 0, -128 - 5 )

	m.boxes.ony = m.create_box( content, {
		id = "ony",
		name = m.T[ "Onyxia" ],
		background = m.images[ "ony" ],
		header = m.T[ "Onyxia" ],
		sub2 = string.format( m.T[ "Resets every %d days" ], 5 ),
		width = bw,
		height = bh
	} )
	m.boxes.ony:SetPoint( "TopLeft", m.boxes.raid40, "TopRight", 5, 0 )

	m.boxes.kara = m.create_box( content, {
		id = "kara",
		name = m.T[ "Karazhan" ],
		background = m.images[ "kara" ],
		header = m.T[ "Karazhan" ],
		sub2 = string.format( m.T[ "Resets every %d days" ], 5 ),
		width = bw,
		height = bh
	} )
	m.boxes.kara:SetPoint( "TopLeft", m.boxes.ony, "TopRight", 5, 0 )

	m.boxes.zg = m.create_box( content, {
		id = "zg",
		name = m.T[ "Raid" ] .. " 20",
		background = m.images[ "zg" ],
		header = m.T[ "Raid" ] .. " 20",
		sub1 = "ZG/AQ20",
		sub2 = string.format( m.T[ "Resets every %d days" ], 3 ),
		width = bw,
		height = bh
	} )
	m.boxes.zg:SetPoint( "TopLeft", m.boxes.kara, "TopRight", 5, 0 )

	m.boxes.eom = m.create_box( content, {
		id = "eom",
		name = m.T[ "Edge of Madness" ],
		background = m.images[ "eom" ],
		header = "Boss",
		sub1 = m.T[ "Zul'Gurub" ] .. " " .. m.T[ "Edge of Madness" ],
		sub2 = string.format( m.T[ "Resets every %d days" ], 14 ),
		width = bw,
		height = bh
	} )
	m.boxes.eom:SetPoint( "TopLeft", m.boxes.zg, "TopRight", 5, 0 )

	m.boxes.bg = m.create_box( content, {
		id = "bg",
		name = m.T[ "Battleground" ],
		background = m.images[ "bg_arathi" ],
		header = "Arathi",
		sub1 = m.T[ "BG of the day" ],
		sub2 = m.T[ "Resets every day" ],
		width = 413,
		height = 184 -- 413 * 0.4453125
	} )
	m.boxes.bg:SetPoint( "TopLeft", m.boxes.raid40, "BottomLeft", 0, -5 )

	m.boxes.dmf = m.create_box( content, {
		id = "dmf",
		name = m.T[ "Darkmoon faire" ],
		background = m.images[ "Thunder Bluff" ],
		header = "Day off",
		sub1 = "It will be back tomorrow",
		sub2 = "Stays at Thuner Bluff until",
		width = 413,
		height = 184
	} )
	m.boxes.dmf:SetPoint( "TopLeft", m.boxes.bg, "TopRight", 5, 0 )

	m.boxes.instances = m.create_box( content, {
		id = "instances",
		name = m.T[ "Instances" ],
		background = m.images[ "instances" ],
		header = m.T[ "Instances" ],
		width = bw,
		height = 184,
	} )
	m.boxes.instances:SetPoint( "TopLeft", m.boxes.dmf, "TopRight", 5, 0 )

	frame.resize_grip = m.resize_grip( frame )
	frame.resize_grip:SetPoint( "BottomRight", frame, "BottomRight", -6, 6 )

	frame:SetScript( "OnUpdate", m.on_update )
	frame:SetScript( "OnShow", function()
		RequestRaidInfo()
		m.delta = 1
	end )

	m.popup_frame = CreateFrame( "Frame", "TurtleCalendarDropDown", frame, "UIDropDownMenuTemplate" )
	m.popup_frame.initialize = m.popup_initialize

	m.pfui_skin( frame )
	return frame
end

function TurtleCalendar.resize_grip( parent, on_start, on_end )
	local button = m.api.CreateFrame( "Button", nil, parent )
	button:SetWidth( 16 )
	button:SetHeight( 16 )
	button:SetNormalTexture( "Interface\\AddOns\\TurtleCalendar\\assets\\resize-grip.tga", "ARTWORK" )
	button:GetNormalTexture():SetAllPoints( button )

	button:SetScript( "OnEnter", function()
		button:GetNormalTexture():SetBlendMode( "ADD" )
	end )
	button:SetScript( "OnLeave", function()
		button:GetNormalTexture():SetBlendMode( "BLEND" )
	end )
	button:SetScript( "OnMouseDown", function()
		parent:StartSizing( "BOTTOMRIGHT" )
		if on_start then on_start( parent ) end
	end )
	button:SetScript( "OnMouseUp", function()
		parent:StopMovingOrSizing()
		if on_end then on_end( parent ) end
	end )

	return button
end

function TurtleCalendar.on_update()
	m.delta = m.delta + arg1
	if m.delta >= 1 then
		m.delta = 0
		m.server_time = m.get_server_time()

		-- Raid timers
		for k, v in pairs( m.timers[ m.realm ] ) do
			---@type BoxFrame
			local box = m.boxes[ k ]
			if box and box.is_visible then
				local next = m.next_raid( v )
				if m.db.show_timers then
					local sec_left = next - m.server_time
					local days, hours, min, sec = m.seconds_dhms( sec_left )

					box.days.set_digit( days )
					box.hours.set_digit( hours )
					box.min.set_digit( min )
					box.sec.set_digit( sec )

					box.time:SetPoint( "Center", box, "Center", 0, 0 )
					box.days:Show()
					box.hours:Show()

					if m.db.condensed_timers then
						if days == 0 then
							local offset = 20
							box.days:Hide()

							if hours == 0 then
								box.hours:Hide()
								offset = offset + 19
							end
							box.time:SetPoint( "Center", box, "Center", -offset, 0 )
						end
					end
				end

				if m.db.show_dates then
					box.date:SetText( date( m.db.date_format, time( date( "*t", next ) ) ) )
				end
			end
		end

		-- Instances timers
		m.clear_expired_instances()
		local box = m.boxes.instances
		if box.is_visible then
			local now = time()
			for i, instance in ipairs( m.db.instances ) do
				if i > 5 then return end
				box[ "inst" .. i .. "_name" ]:SetText( instance.name )
				box[ "inst" .. i .. "_name" ]:SetJustifyH( "Left" )
				box[ "inst" .. i .. "_time" ]:SetText( date( "%Mm%Ss", 3600 - (now - instance.timestamp) ) )
			end
			for i = getn( m.db.instances ) + 1, 5 do
				if i > 5 then return end
				box[ "inst" .. i .. "_name" ]:SetText( "" )
				box[ "inst" .. i .. "_time" ]:SetText( "" )
			end
			box.sub2:SetText( getn( m.db.instances ) == 0 and m.T[ "No lockouts" ] or "" )
		end

		-- World Buffs
		m.world_buffs.clear_expired_timers()
		box = m.boxes.wbuffs
		if box.is_visible then
			local buffs_a = m.world_buffs.get_buffs( "A" )
			local buffs_h = m.world_buffs.get_buffs( "H" )
			local total_width = 0

			for i = 1, 5 do
				local string = (m.db.show_sw_buffs and i < 3 and buffs_a[ i ]) or (m.db.show_og_buffs and i > 3 and buffs_h[ i - 3 ]) or
						(i == 3 and (m.db.show_sw_buffs and m.db.show_og_buffs) and " | ") or ""

				box.buff_frame[ "text_frame" .. i ].text:SetText( string )
				local width = box.buff_frame[ "text_frame" .. i ].text:GetWidth() or 0

				box.buff_frame[ "text_frame" .. i ]:SetWidth( width )
				total_width = total_width + width
			end
			box.buff_frame:SetWidth( total_width )
		end

		if (m.sday ~= m.server_day_number()) then
			m.refresh()
		end
	end
end

function TurtleCalendar.refresh()
	if not m.popup or not m.popup:IsVisible() then
		return
	end

	m.sday = m.server_day_number()

	-- Raids
	m.boxes.raid40.inst_name:SetText( "" )
	m.boxes.raid40.inst_id:SetText( "" )
	m.boxes.zg.inst_name:SetText( "" )
	m.boxes.zg.inst_id:SetText( "" )

	if m.instances then
		for k, v in pairs( m.raids ) do
			local box = m.boxes[ v ]
			if m.instances[ k ] and box.is_visible then
				if v == "kara" or v == "ony" then
					m.boxes[ v ].sub1:SetText( string.format( "ID: " .. m.colors.yellow .. "%s|r", m.instances[ k ].id ) )
				else
					box.inst_name:SetText( (box.inst_name:GetText() or "") .. k .. "\n" )
					box.inst_id:SetText( (box.inst_id:GetText() or "") .. m.instances[ k ].id .. "\n" )
				end
			end
		end
	end

	for k in pairs( m.timers[ m.realm ] ) do
		---@type BoxFrame
		local box = m.boxes[ k ]
		if m.db.show_timers then box.time:Show() else box.time:Hide() end
		if m.db.show_dates then
			box.date:Show()
			if m.db.show_timers then
				box.date:SetPoint( "Bottom", box, "Bottom", 0, 15 )
				box.date:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\Monaco.ttf", 12, "" )
			else
				box.date:SetPoint( "Bottom", box, "Bottom", 0, 60 )
				box.date:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\Monaco.ttf", 22, "" )
			end
		else
			box.date:Hide()
		end
		if box.data.id == "bg" then
			box.date:SetPoint( "Bottom", box, "Bottom", 0, m.db.show_timers and 48 or 65 )
			box.time:SetPoint( "Bottom", box, "Bottom", 0, m.db.show_dates and 65 or 55 )
		end
	end

	-- Edge of Madness
	local eom_idx = mod( math.floor( (m.sday + 2) / m.timers[ m.realm ][ "eom" ].interval ), 4 ) + 1

	m.boxes.eom.header:SetText( m.eom[ eom_idx ].name )
	m.boxes.eom.mob:SetTexture( m.images[ "eom_" .. m.eom[ eom_idx ].id ].image )

	-- Battleground
	local bg_idx = mod( (m.sday - 3), 5 ) + 1

	m.boxes.bg.header:SetText( m.bgs[ bg_idx ].name )
	m.boxes.bg.bg:SetTexture( m.images[ "bg_" .. m.bgs[ bg_idx ].id ].image )

	bg_idx = mod( (m.sday - 2), 5 ) + 1
	m.boxes.bg.next_day:SetText( m.T[ "Coming next day: " ] .. m.bgs[ bg_idx ].name )
	m.boxes.bg.next_bg:SetTexture( m.images[ "bg_" .. m.bgs[ bg_idx ].id ].image )

	-- Darkmoon Fair
	local dmf_idx = mod( math.floor( (m.sday - 3) / m.timers[ m.realm ][ "dmf" ].interval ), 2 ) + 1
	local now = date( "!*t", m.get_server_time() )
	local dmf = dmf_idx == 1 and m.T[ "Thunder Bluff" ] or m.T[ "Goldshire" ]
	local dmf_img = dmf_idx == 1 and "Thunder Bluff" or "Goldshire"

	m.boxes.dmf.bg:SetTexture( m.images[ dmf_img ].image )
	if now.wday == 4 then
		m.boxes.dmf.header:SetText( m.T[ "Day off" ] )
		m.boxes.dmf.sub1:SetText( m.T[ "It will be back tomorrow" ] )
		m.boxes.dmf.sub2:SetText( string.format( m.T[ "Stays at %s until" ], dmf ) )
	else
		m.boxes.dmf.header:SetText( dmf or "" )
		m.boxes.dmf.sub1:SetText( m.T[ "Darkmoon Faire position" ] )
		m.boxes.dmf.sub2:SetText( m.T[ "Moves out every Sunday" ] )
	end

	m.reorder()
end

function TurtleCalendar.popup_menu()
	if arg1 == "RightButton" then
		m.popup_box = this.id
		ToggleDropDownMenu( 1, nil, m.popup_frame, "cursor", 0, 0 )
	end
end

function TurtleCalendar.popup_initialize( level )
	local function toggle_setting( setting )
		m.db[ setting ] = not this.checked
		m.refresh()
		m.delta = 1
	end

	local function on_raid_click( arg1 )
		m.db.boxes[ arg1 ][ 2 ] = not this.checked
		m.reorder()
	end

	if level == 1 then
		UIDropDownMenu_AddButton( { isTitle = true, notCheckable = true, text = m.T[ "Global" ] } )
		UIDropDownMenu_AddButton( {
			text = m.T[ "Condensed timers" ],
			arg1 = "condensed_timers",
			keepShownOnClick = 1,
			checked = m.db.condensed_timers,
			func = toggle_setting
		} )
		UIDropDownMenu_AddButton( {
			text = m.T[ "Show timers" ],
			arg1 = "show_timers",
			keepShownOnClick = 1,
			checked = m.db.show_timers,
			func = toggle_setting
		} )
		UIDropDownMenu_AddButton( {
			text = m.T[ "Show dates" ],
			arg1 = "show_dates",
			keepShownOnClick = 1,
			checked = m.db.show_dates,
			func = toggle_setting
		} )
		UIDropDownMenu_AddButton( { isTitle = true, notCheckable = true, text = m.T[ "Raids" ] } )

		local info = {
			func = on_raid_click,
			keepShownOnClick = 1
		}

		for i, box in ipairs( m.db.boxes ) do
			if i == 6 then
				UIDropDownMenu_AddButton( { isTitle = true, notCheckable = true, text = m.T[ "Misc" ] } )
			end
			info.text = m.boxes[ box[ 1 ] ].data.name
			info.arg1 = i
			info.checked = m.boxes[ box[ 1 ] ].is_visible
			UIDropDownMenu_AddButton( info )
		end

		UIDropDownMenu_AddButton( {
			text = m.T[ "World Buffs" ],
			arg1 = "show_world_buffs",
			keepShownOnClick = 1,
			menuList = "WorldBuffs",
			hasArrow = true,
			checked = m.db.show_world_buffs,
			func = toggle_setting
		} )

		UIDropDownMenu_AddButton( {
			text = m.T[ "Weekly quest reminder" ],
			arg1 = "show_weekly_quests_alert",
			keepShownOnClick = 1,
			checked = m.db.show_weekly_quests_alert,
			func = toggle_setting
		}	)
	elseif level == 2 then
		UIDropDownMenu_AddButton( {
			text = m.T[ "Stormwind buffs" ],
			arg1 = "show_sw_buffs",
			keepShownOnClick = 1,
			checked = m.db.show_sw_buffs,
			func = toggle_setting
		}, level )

		UIDropDownMenu_AddButton( {
			text = m.T[ "Orgrimmar buffs" ],
			arg1 = "show_og_buffs",
			keepShownOnClick = 1,
			checked = m.db.show_og_buffs,
			func = toggle_setting
		}, level )
	end
end

function TurtleCalendar.on_resize()
	local self = m.popup
	local min_width, max_width = m.width / 1.7, m.width
	local width = math.max( min_width, math.min( max_width, self:GetWidth() ) )
	local scale = (width - (m.frame_padding * 2)) / (m.width - (m.frame_padding * 2))
	local height = width * (m.height / m.width)
	height = height + (20 * (m.height / height)) - 20
	m.db.scale = width / m.width

	self.content:SetPoint( "TopLeft", self, "TopLeft", m.frame_padding * (m.width / width), -(20 + m.frame_padding) * (m.width / width) )
	self.content:SetScale( scale )
	self:SetWidth( width )
	self:SetHeight( height )
end

function TurtleCalendar.reorder()
	-- This really needs refactoring
	local pos = 1
	local prev_box
	local line1
	local line2
	local top = 0

	if m.db.show_world_buffs then
		top = -35
	end

	for i, box_info in ipairs( m.db.boxes ) do
		---@type BoxFrame
		local box = m.boxes[ box_info[ 1 ] ]

		box.set_visibility( box_info[ 2 ] )
		if box_info[ 2 ] then
			if i <= 5 then
				if pos == 1 then
					box:SetPoint( "TopLeft", m.popup.content, "TopLeft", 0, top )
					line1 = 1
				else
					box:SetPoint( "TopLeft", prev_box, "TopRight", 5, 0 )
					line1 = line1 + 1
				end
			else
				if not line2 then
					box:SetPoint( "TopLeft", m.popup.content, "TopLeft", 0, top - (222 + 5) )
					line2 = 1
				else
					box:SetPoint( "TopLeft", prev_box, "TopRight", 5, 0 )
					line2 = line2 + 1
				end
			end
			pos = pos + 1
			prev_box = box
		end
	end

	if line2 then
		if line1 then
			m.height = 460
			if line1 < 2 and line2 < 2 and m.db.boxes[ 8 ][ 2 ] then
				m.width = 1070 - 209 - 209 - 209 - 209
			elseif line1 < 3 and line2 < 2 then
				m.width = 1070 - 209 - 209 - 209
			elseif line1 < 5 and line2 < 3 then
				if line1 < 4 and (line2 < 2 or m.db.boxes[ 8 ][ 2 ]) then
					m.width = 1070 - 209 - 209
				else
					m.width = 1070 - 209
				end
			else
				m.width = 1070
			end
		end
	else
		m.height = 460 - 189
		m.width = 25 + (line1 or 1) * 209
	end

	if line1 == 4 and line2 == 2 and m.boxes.instances.is_visible then
		m.boxes.instances:SetWidth( 413 )
		m.boxes.instances.bg:SetTexture( m.images.instances2.image )
		m.boxes.instances.bg:SetTexCoord( 0, 1, 0, m.images.instances2.height )
		for i = 1, 5 do
			m.boxes.instances[ "inst" .. i .. "_name" ]:SetWidth( 340 )
		end
	else
		m.boxes.instances:SetWidth( 204 )
		m.boxes.instances.bg:SetTexture( m.images.instances.image )
		m.boxes.instances.bg:SetTexCoord( 0, 1, 0, m.images.instances.height )
		for i = 1, 5 do
			m.boxes.instances[ "inst" .. i .. "_name" ]:SetWidth( 135 )
		end
	end

	m.height = m.height - top
	m.width = m.width - 30 + (m.frame_padding * 2)
	m.height = m.height - 30 + (m.frame_padding * 2)

	local box = m.boxes[ "wbuffs" ]
	box.set_visibility( m.db.show_world_buffs )
	if m.db.show_world_buffs then
		box.sub1:SetWidth( m.width - (m.frame_padding * 3) - 5 )
		box.sub1:SetHeight( 10 )
		if m.db.show_og_buffs and m.db.show_sw_buffs and m.width < 700 then
			box.sub2:Hide()
		else
			if m.width < 500 then
				box.sub2:Hide()
			else
				box.sub2:Show()
			end
		end
	end

	m.popup:SetWidth( m.width * (m.db.scale or 1) )
	m.on_resize()
end

function TurtleCalendar.show()
	if not m.popup then
		m.popup = m.create_frame()
	end
	m.popup:Show()
	m.refresh()
end

function TurtleCalendar.hide()
	if m.popup then
		m.popup:Hide()
	end
end

function TurtleCalendar.toggle()
	if m.popup and m.popup:IsVisible() then
		m.hide()
	else
		m.show()
	end
end

function TurtleCalendar.slashHandler( args )
	if string.find( args, "^help" ) then
		m.info( "TurtleCalendar commands:", true )
		m.info( "/tc reset - Manually reset current instance timer", true )
		m.info( "/tc minimap - Toggle minimap button", true )
		m.info( "/tc dateform [format] - Sets date format. See readme for details", true )
		return
	elseif string.find( args, "^reset" ) then
		if m.db.last_instance ~= "" then
			m.info( m.db.last_instance .. " has been reset." )
			m.reset_instances()
		else
			m.info( "No instance to reset." )
		end
		return
	elseif string.find( args, "^dateformat" ) then
		local date_format = string.gsub( args, "^dateformat (.*)", "%1" )
		m.db.date_format = date_format
		return
	elseif string.find( args, "^minimap" ) then
		m.db.minimap_icon.hide = not m.db.minimap_icon.hide
		if m.db.minimap_icon.hide then
			m.info( "Minimap button is now hidden." )
			m.minimap_icon.icon:Hide( m.name )
		else
			m.info( "Minimap button is now visible." )
			m.minimap_icon.icon:Show( m.name )
		end
		return
	elseif string.find( args, "^debug" ) then
		m.debug_enabled = not m.debug_enabled
		m.info( "Debug is " .. (m.debug_enabled and "enabled." or "disabled.") )
		return
	end
	m.toggle()
end

---@param message string
---@param short boolean?
function TurtleCalendar.info( message, short )
	local tag = string.format( "%s%s|r", m.colors.tag, short and "TC" or "TurtleCalendar" )
	DEFAULT_CHAT_FRAME:AddMessage( string.format( "%s: %s", tag, message ) )
end

---@param message string
function TurtleCalendar.debug( message )
	if m.debug_enabled then
		local tag = string.format( "%s%s|r", m.colors.tag, "TC" )
		DEFAULT_CHAT_FRAME:AddMessage( string.format( "%s: %s", tag, message ) )
	end
end

function TurtleCalendar.get_utc_offset()
	-- Calculate the difference between local time and UTC
	-- by comparing the number of seconds since the start of the year
	local now = time()
	local utc_table = date( "!*t", now )
	local utc_seconds = (utc_table.hour * 3600) + (utc_table.min * 60) + utc_table.sec + ((utc_table.yday - 1) * 24 * 3600)
	local local_table = date( "*t", now )
	local local_seconds = (local_table.hour * 3600) + (local_table.min * 60) + local_table.sec + ((local_table.yday - 1) * 24 * 3600)

	return local_seconds - utc_seconds
end

function TurtleCalendar.time_utc( t )
	return time( t ) + m.utc_offset
end

---@return integer seconds
---@nodiscard
function TurtleCalendar.get_server_time()
	local server_ts = time()
	server_ts = server_ts

	return server_ts
end

---@return integer
function TurtleCalendar.server_day_number()
	local server_ts = TurtleCalendar.get_server_time()

	return math.floor( server_ts / 86400 )
end

---@param raid table
---@return integer seconds
---@nodiscard
function TurtleCalendar.next_raid( raid )
	if m.server_time < raid.anchor then
		return raid.anchor
	end

	local elapsed = m.server_time - raid.anchor
	local interval = raid.interval * 86400
	local cycles = math.floor( elapsed / interval )

	return raid.anchor + (cycles + 1) * interval
end

---@param seconds integer
---@return integer days
---@return integer hours
---@return integer min
---@return integer seconds
---@nodiscard
function TurtleCalendar.seconds_dhms( seconds )
	local days = math.floor( seconds / 86400 )
	seconds = mod( seconds, 86400 )
	local hours = math.floor( seconds / 3600 )
	seconds = mod( seconds, 3600 )
	local min = math.floor( seconds / 60 )
	seconds = mod( seconds, 60 )

	return days, hours, min, seconds
end

function TurtleCalendar.get_last_thursday( ts )
	ts = ts or time()
	-- Server is 4h ahead of UTC
	local t = date( "*t", m.time_utc( date( "*t", ts ) ) - (3600 * 4) )
	local wday = t.wday
	local days_back = (wday >= 5) and (wday - 5) or (7 - (5 - wday))
	t.day = t.day - days_back
	t.hour = 0
	t.min = 0
	t.sec = 0

	return time( t )
end

---@param value string|number
---@param t table
---@param extract_field string?
function TurtleCalendar.find( value, t, extract_field )
	if type( t ) ~= "table" or m.count( t ) == 0 then return nil end

	for i, v in pairs( t ) do
		local val = extract_field and v[ extract_field ] or v
		if val == value then return v, i end
	end

	return nil
end

---@param t table
---@return number
function TurtleCalendar.count( t )
	local count = 0
	for _ in pairs( t ) do
		count = count + 1
	end

	return count
end

-- Split the provided string by the specified delimiter.
function TurtleCalendar.str_split( str, delimiter )
	if not str then return nil end
	delimiter = delimiter or ":"
	local fields = {}
	local pattern = string.format( "([^%s]+)", delimiter )
	string.gsub( str, pattern, function( c ) fields[ getn( fields ) + 1 ] = c end )
	return unpack( fields )
end

function TurtleCalendar.pfui_skin( frame )
	if not m.pfui_skin_enabled then return end

	m.frame_padding = 8
	m.boxes.wbuffs:SetPoint( "Right", frame.content, "Right", -m.frame_padding, 0 )

	m.api.pfUI.api.StripTextures( frame, nil, "BACKGROUND" )
	m.api.pfUI.api.CreateBackdrop( frame, nil, true, 0.8 )

	frame.title_bar:SetPoint( "TopLeft", frame, "TopLeft", 2, -2 )
	frame.title_bar:SetPoint( "BottomRight", frame, "TopRight", -2, -22 )
	m.api.pfUI.api.SkinCloseButton( frame.title_bar.btn_close, frame.title_bar, -1, -1 )

	local rr, rg, rb, ra = m.api.pfUI.api.GetStringColor( m.api.pfUI_config.appearance.border.color )
	frame.title_bar.line1:SetBackdropColor( rr, rg, rb, ra )
	frame.title_bar.line2:Hide()

	for _, box in pairs( m.boxes ) do
		box:SetBackdropBorderColor( rr, rg, rb, ra )
	end

	frame.resize_grip:SetPoint( "BottomRight", frame, "BottomRight", 2, -2 )
end

TurtleCalendar:init()
