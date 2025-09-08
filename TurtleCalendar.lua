---@class TurtleCalendar
TurtleCalendar = TurtleCalendar or {}

---@class TurtleCalendar
local m = TurtleCalendar

BINDING_HEADER_TURTLECALENDAR_HEADER = "Turtle Calendar"
BINDING_NAME_TURTLECALENDAR_OPENMENU = "Toggle the calendar"

TurtleCalendar.name = "TurtleCalendar"
TurtleCalendar.tagcolor = "FF4E8A00"
TurtleCalendar.events = {}
TurtleCalendar.debug_enabled = false

TurtleCalendar.images = {
	[ "bwl" ] = { image = "Interface\\AddOns\\TurtleCalendar\\assets\\bwl.blp", height = 276 / 512 },
	[ "ony" ] = { image = "Interface\\AddOns\\TurtleCalendar\\assets\\ony.blp", height = 276 / 512 },
	[ "kara" ] = { image = "Interface\\AddOns\\TurtleCalendar\\assets\\kara.blp", height = 276 / 512 },
	[ "zg" ] = { image = "Interface\\AddOns\\TurtleCalendar\\assets\\zg.blp", height = 276 / 512 },
	[ "eom" ] = { image = "Interface\\AddOns\\TurtleCalendar\\assets\\eom.blp", height = 276 / 512 },
	[ "instances" ] = { image = "Interface\\AddOns\\TurtleCalendar\\assets\\instances.blp", height = 276 / 512 },
	[ "instances2" ] = { image = "Interface\\AddOns\\TurtleCalendar\\assets\\instances2.blp", height = 208 / 256 },
	[ "Thunder Bluff" ] = { image = "Interface\\AddOns\\TurtleCalendar\\assets\\dmf_tb.blp", height = 228 / 256 },
	[ "Goldshire" ] = { image = "Interface\\AddOns\\TurtleCalendar\\assets\\dmf_gs.blp", height = 228 / 256 },
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
	[ 1 ] = { id = "av", name = "Alterac Valley" },
	[ 2 ] = { id = "wg", name = "Warsong Gulch" },
	[ 3 ] = { id = "arathi", name = "Arathi Basin" },
	[ 4 ] = { id = "bra", name = "Blood Ring Arena" },
	[ 5 ] = { id = "sgv", name = "Sunnyglade Valley" }
}

TurtleCalendar.eom = {
	[ 1 ] = { id = "grilek", name = "Gri'lek" },
	[ 2 ] = { id = "hazzarah", name = "Hazza'rah" },
	[ 3 ] = { id = "renataki", name = "Renataki" },
	[ 4 ] = { id = "wushoolay", name = "Wushoolay" }
}

TurtleCalendar.raids = {
	[ "Molten Core" ] = "raid40",
	[ "Blackwing Lair" ] = "raid40",
	[ "Temple of Ahn'Qiraj" ] = "raid40",
	[ "Naxxramas" ] = "raid40",
	[ "Emerald Sanctum" ] = "raid40",
	[ "Onyxia's Lair" ] = "ony",
	[ "Lower Karazhan Halls" ] = "kara",
	[ "Zul'Gurub" ] = "zg",
	[ "Ruins of Ahn'Qiraj" ] = "zg",
}

TurtleCalendar.timers = {
	[ "Nordanaar" ] = {
		[ "raid40" ] = { interval = 7, anchor = time { year = 2025, month = 9, day = 3, hour = 4 } },
		[ "ony" ] = { interval = 5, anchor = time { year = 2025, month = 9, day = 1, hour = 4 } },
		[ "kara" ] = { interval = 5, anchor = time { year = 2025, month = 9, day = 2, hour = 4 } },
		[ "zg" ] = { interval = 3, anchor = time { year = 2025, month = 8, day = 30, hour = 4 } },
		[ "eom" ] = { interval = 14, anchor = time { year = 2025, month = 4, day = 8, hour = 0 } },
		[ "bg" ] = { interval = 1, anchor = time { year = 2025, month = 9, day = 1, hour = 0 } },
		[ "dmf" ] = { interval = 7, anchor = time { year = 2025, month = 9, day = 0, hour = 0 } }
	},
	[ "Tel'Abim" ] = {
		[ "raid40" ] = { interval = 7, anchor = time { year = 2025, month = 9, day = 4, hour = 4 } },
		[ "ony" ] = { interval = 5, anchor = time { year = 2025, month = 9, day = 0, hour = 4 } },
		[ "kara" ] = { interval = 5, anchor = time { year = 2025, month = 9, day = 0, hour = 4 } },
		[ "zg" ] = { interval = 3, anchor = time { year = 2025, month = 8, day = 28, hour = 4 } },
		[ "eom" ] = { interval = 14, anchor = time { year = 2025, month = 4, day = 8, hour = 0 } },
		[ "bg" ] = { interval = 1, anchor = time { year = 2025, month = 9, day = 1, hour = 0 } },
		[ "dmf" ] = { interval = 7, anchor = time { year = 2025, month = 9, day = 0, hour = 0 } }
	},
	[ "Ambershire" ] = {
		[ "raid40" ] = { interval = 7, anchor = time { year = 2025, month = 9, day = 3, hour = 4 } },
		[ "ony" ] = { interval = 5, anchor = time { year = 2025, month = 9, day = 1, hour = 4 } },
		[ "kara" ] = { interval = 5, anchor = time { year = 2025, month = 9, day = 2, hour = 4 } },
		[ "zg" ] = { interval = 3, anchor = time { year = 2025, month = 8, day = 30, hour = 4 } },
		[ "eom" ] = { interval = 14, anchor = time { year = 2025, month = 4, day = 8, hour = 0 } },
		[ "bg" ] = { interval = 1, anchor = time { year = 2025, month = 9, day = 1, hour = 0 } },
		[ "dmf" ] = { interval = 7, anchor = time { year = 2025, month = 9, day = 0, hour = 0 } }
	},
}

function TurtleCalendar:init()
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

	m.time_offset = 3600
	m.delta = 1
	m.realm = GetRealmName()
	m.api = getfenv()

	---@class MinimapIcon
	m.minimap_icon = m.MinimapIcon.new()

	m.api[ "SLASH_TurtleCalendar1" ] = "/tc"
	m.api[ "SLASH_TurtleCalendar2" ] = "/TurtleCalendar"
	SlashCmdList[ "TurtleCalendar" ] = m.slashHandler

	m.version = GetAddOnMetadata( m.name, "Version" )
	m.info( string.format( "(v%s) Loaded", m.version ) )
end

function TurtleCalendar.events.PLAYER_ENTERING_WORLD()
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
			if (now - v.timestamp < m.time_offset) then
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

	local bg = frame:CreateTexture( nil, "ARTWORK" )
	bg:SetPoint( "TopLeft", frame, "TopLeft", 4, -4 )
	bg:SetPoint( "BottomRight", frame, "BottomRight", -4, 4 )
	bg:SetTexture( data.background.image )
	bg:SetTexCoord( 0, 1, 0, data.background.height )
	bg:SetVertexColor( 1, 1, 1, 0.5 )
	frame.bg = bg

	if data.id == "eom" then
		local mob = frame:CreateTexture( nil, "OVERLAY" )
		mob:SetWidth( 220 )
		mob:SetHeight( 220 )
		mob:SetPoint( "Center", frame, "Center", 0, 0 )
		mob:SetTexture( m.images[ "eom_hazzarah" ].image )
		mob:SetVertexColor( 0.6, 0.6, 0.6, 1 )
		frame.mob = mob
	end

	local header = frame:CreateFontString( nil, "OVERLAY" )
	header:SetPoint( "Center", frame, "Center", 0, 0 )
	header:SetPoint( "Top", frame, "Top", 0, -20 )
	header:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\AoboshiOne.ttf", 25, "" )
	header:SetText( data.header )
	frame.header = header

	if data.id == "instances" then
		for i = 1, 5 do
			local name = frame:CreateFontString( nil, "OVERLAY" )
			name:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\AoboshiOne.ttf", 11, "" )
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

	local sub1 = frame:CreateFontString( nil, "OVERLAY" )
	sub1:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\AoboshiOne.ttf", 11, "" )
	sub1:SetPoint( "Center", frame, "Center", 0, 0 )
	sub1:SetPoint( "Top", header, "Bottom", 0, -5 )
	sub1:SetText( data.sub1 or " " )
	frame.sub1 = sub1

	local sub2 = frame:CreateFontString( nil, "OVERLAY" )
	sub2:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\AoboshiOne.ttf", 10, "" )
	sub2:SetTextColor( 0.8, 0.8, 0.8, 1 )
	sub2:SetPoint( "Center", frame, "Center", 0, 0 )
	sub2:SetPoint( "Top", sub1, "Bottom", 0, -5 )
	sub2:SetText( data.sub2 )
	frame.sub2 = sub2

	if data.id ~= "instances" then
		local sub3 = frame:CreateFontString( nil, "OVERLAY" )
		sub3:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\AoboshiOne.ttf", 10, "" )
		sub3:SetTextColor( 0.8, 0.8, 0.8, 1 )
		sub3:SetPoint( "Center", frame, "Center", 0, 0 )
		sub3:SetPoint( "Top", sub2, "Bottom", 0, -5 )
		frame.sub3 = sub3

		local inst_name = frame:CreateFontString( nil, "OVERLAY" )
		inst_name:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\AoboshiOne.ttf", 10, "" )
		inst_name:SetTextColor( 0.8, 0.8, 0.8, 1 )
		inst_name:SetPoint( "TopLeft", frame, "TopLeft", 30, -90 )
		inst_name:SetJustifyH( "Left" )
		frame.inst_name = inst_name

		local inst_id = frame:CreateFontString( nil, "OVERLAY" )
		inst_id:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\AoboshiOne.ttf", 10, "" )
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

		local days = time:CreateFontString( nil, "OVERLAY" )
		days:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\Monaco.ttf", 25, "" )
		days:SetTextColor( 0.8, 0.8, 0.8, 1 )
		days:SetPoint( "TopLeft", time, "TopLeft", 0, 0 )
		frame.days = days

		local label_days = time:CreateFontString( nil, "OVERLAY" )
		label_days:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\Monaco.ttf", 8, "" )
		label_days:SetTextColor( 0.8, 0.8, 0.8, 1 )
		label_days:SetPoint( "Center", days, "Center", 0, 0 )
		label_days:SetPoint( "Top", days, "Bottom", 0, 0 )
		label_days:SetText( "days" )
		frame.label_days = label_days

		local hours = time:CreateFontString( nil, "OVERLAY" )
		hours:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\Monaco.ttf", 25, "" )
		hours:SetTextColor( 0.8, 0.8, 0.8, 1 )
		hours:SetPoint( "BottomLeft", days, "BottomRight", 15, 0 )
		frame.hours = hours

		local label_hours = time:CreateFontString( nil, "OVERLAY" )
		label_hours:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\Monaco.ttf", 8, "" )
		label_hours:SetTextColor( 0.8, 0.8, 0.8, 1 )
		label_hours:SetPoint( "Center", hours, "Center", 0, 0 )
		label_hours:SetPoint( "Top", hours, "Bottom", 0, 0 )
		label_hours:SetText( "hours" )
		frame.label_hours = label_hours

		local min = time:CreateFontString( nil, "OVERLAY" )
		min:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\Monaco.ttf", 25, "" )
		min:SetTextColor( 0.8, 0.8, 0.8, 1 )
		min:SetPoint( "BottomLeft", hours, "BottomRight", 15, 0 )
		frame.min = min

		local label_min = time:CreateFontString( nil, "OVERLAY" )
		label_min:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\Monaco.ttf", 8, "" )
		label_min:SetTextColor( 0.8, 0.8, 0.8, 1 )
		label_min:SetPoint( "Center", min, "Center", 0, 0 )
		label_min:SetPoint( "Top", min, "Bottom", 0, 0 )
		label_min:SetText( "min" )

		local sec = time:CreateFontString( nil, "OVERLAY" )
		sec:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\Monaco.ttf", 10, "" )
		sec:SetTextColor( 0.8, 0.8, 0.8, 1 )
		sec:SetPoint( "BottomLeft", min, "BottomRight", 10, 0 )
		frame.sec = sec

		local label_sec = time:CreateFontString( nil, "OVERLAY" )
		label_sec:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\Monaco.ttf", 8, "" )
		label_sec:SetTextColor( 0.8, 0.8, 0.8, 1 )
		label_sec:SetPoint( "TopLeft", sec, "BottomLeft", 0, 0 )
		label_sec:SetText( "sec" )

		local date = frame:CreateFontString( nil, "OVERLAY" )
		date:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\Monaco.ttf", 12, "" )
		date:SetPoint( "Center", frame, "Center", 0, 0 )
		date:SetPoint( "Top", time, "Bottom", 0, -5 )
		frame.date = date
	end

	if data.id == "bg" then
		bg:SetPoint( "BottomRight", frame, "BottomRight", -4, 45 )
		frame.time:SetPoint( "Bottom", frame, "Bottom", 0, 65 )

		local next_bg = frame:CreateTexture( nil, "ARTWORK" )
		next_bg:SetPoint( "TopLeft", frame, "BottomLeft", 4, 43 )
		next_bg:SetPoint( "BottomRight", frame, "BottomRight", -4, 4 )
		next_bg:SetTexCoord( 0, 1, 0, data.background.height )
		next_bg:SetVertexColor( 1, 1, 1, 0.2 )
		frame.next_bg = next_bg

		local next_day = frame:CreateFontString( nil, "OVERLAY" )
		next_day:SetFont( "Interface\\AddOns\\TurtleCalendar\\assets\\AoboshiOne.ttf", 12, "" )
		next_day:SetPoint( "Center", frame, "Center", 0, 0 )
		next_day:SetPoint( "Bottom", frame, "Bottom", 0, 20 )
		frame.next_day = next_day
	end

	frame:SetScript( "OnMouseDown", m.popup_menu )

	frame.alpha = 0.4
	frame:SetScript( "OnEnter", function()
		local a = frame.alpha
		frame:SetScript( "OnUpdate", function()
			a = a + 0.01
			bg:SetVertexColor( 1, 1, 1, a )
			if a >= frame.alpha + 0.1 then
				frame:SetScript( "OnUpdate", nil )
			end
		end )
	end )

	frame:SetScript( "OnLeave", function()
		local a = frame.alpha + 0.1
		frame:SetScript( "OnUpdate", function()
			a = a - 0.01
			bg:SetVertexColor( 1, 1, 1, a )
			if a <= frame.alpha then
				frame:SetScript( "OnUpdate", nil )
			end
		end )
	end )

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

	if m.db.position then
		local p = m.db.position
		frame:ClearAllPoints()
		frame:SetPoint( p.point, UIParent, p.relative_point, p.x, p.y )
	end

	-- Title bar
	local title_bar = CreateFrame( "Frame", nil, frame )
	title_bar:SetPoint( "TopLeft", frame, "TopLeft", 11, -11 )
	title_bar:SetPoint( "BottomRight", frame, "TopRight", -11, -31 )
	title_bar:SetBackdrop( { bgFile = "Interface/Buttons/WHITE8x8" } )
	title_bar:SetBackdropColor( 0, 0, 0, 1 )

	local line1 = CreateFrame( "Frame", nil, title_bar )
	line1:SetPoint( "TopLeft", title_bar, "BottomLeft", 0, 2 )
	line1:SetPoint( "BottomRight", title_bar, "BottomRight", 0, 1 )
	line1:SetBackdrop( { bgFile = "Interface/Buttons/WHITE8x8" } )
	line1:SetBackdropColor( 0.6, 0.6, 0.6, 1 )

	local line2 = CreateFrame( "Frame", nil, title_bar )
	line2:SetPoint( "TopLeft", title_bar, "BottomLeft", 0, 1 )
	line2:SetPoint( "BottomRight", title_bar, "BottomRight", 0, 0 )
	line2:SetBackdrop( { bgFile = "Interface/Buttons/WHITE8x8" } )
	line2:SetBackdropColor( 0.3, 0.3, 0.3, 1 )

	local btn_close = CreateFrame( "Button", nil, title_bar, "UIPanelCloseButton" )
	btn_close:SetPoint( "TopRight", title_bar, "TopRight", 7, 7 )
	btn_close:SetScript( "OnClick", function()
		m.hide()
	end )

	local title = title_bar:CreateFontString( nil, "OVERLAY", "GameFontHighlight" )
	title:SetPoint( "Left", title_bar, "Left", 7, 1 )
	title:SetText( "Turtle Calendar v" .. m.version )

	-- Main content
	local bw, bh = 204, 222
	m.boxes = {}

	m.boxes.raid40 = m.create_box( frame, {
		id = "raid40",
		name = "Raid 40",
		background = m.images[ "bwl" ],
		header = "Raid 40",
		sub1 = "MC/BWL/AQ40/Naxx/ES",
		sub2 = "Resets every 7 days",
		width = bw,
		height = bh
	} )
	m.boxes.raid40:SetPoint( "TopLeft", frame, "TopLeft", 15, -35 )

	m.boxes.ony = m.create_box( frame, {
		id = "ony",
		name = "Onyxia",
		background = m.images[ "ony" ],
		header = "Onyxia",
		sub2 = "Resets every 5 days",
		width = bw,
		height = bh
	} )
	m.boxes.ony:SetPoint( "TopLeft", m.boxes.raid40, "TopRight", 5, 0 )

	m.boxes.kara = m.create_box( frame, {
		id = "kara",
		name = "Karazhan",
		background = m.images[ "kara" ],
		header = "Karazhan",
		sub2 = "Resets every 5 days",
		width = bw,
		height = bh
	} )
	m.boxes.kara:SetPoint( "TopLeft", m.boxes.ony, "TopRight", 5, 0 )

	m.boxes.zg = m.create_box( frame, {
		id = "zg",
		name = "Raid 20",
		background = m.images[ "zg" ],
		header = "Raid 20",
		sub1 = "ZG/AQ20",
		sub2 = "Resets every 3 days",
		width = bw,
		height = bh
	} )
	m.boxes.zg:SetPoint( "TopLeft", m.boxes.kara, "TopRight", 5, 0 )

	m.boxes.eom = m.create_box( frame, {
		id = "eom",
		name = "Edge of Madness",
		background = m.images[ "eom" ],
		header = "Boss",
		sub1 = "Zul'Gurub Edge of Madness",
		sub2 = "Resets every 14 days",
		width = bw,
		height = bh
	} )
	m.boxes.eom:SetPoint( "TopLeft", m.boxes.zg, "TopRight", 5, 0 )

	m.boxes.bg = m.create_box( frame, {
		id = "bg",
		name = "Battleground",
		background = m.images[ "bg_arathi" ],
		header = "Arathi",
		sub1 = "BG of the day",
		sub2 = "Resets every day",
		width = 413,
		height = 184 -- 413 * 0.4453125
	} )
	m.boxes.bg:SetPoint( "TopLeft", m.boxes.raid40, "BottomLeft", 0, -5 )

	m.boxes.dmf = m.create_box( frame, {
		id = "dmf",
		name = "Darkmoon faire",
		background = m.images[ "Thunder Bluff" ],
		header = "Day off",
		sub1 = "It will be back tomorrow",
		sub2 = "Stays at Thuner Bluff until",
		width = 413,
		height = 184 -- 413 * 0.4453125
	} )
	m.boxes.dmf:SetPoint( "TopLeft", m.boxes.bg, "TopRight", 5, 0 )

	m.boxes.instances = m.create_box( frame, {
		id = "instances",
		name = "Instances",
		background = m.images[ "instances" ],
		header = "Instances",
		width = bw,
		height = 184,
	} )
	m.boxes.instances:SetPoint( "TopLeft", m.boxes.dmf, "TopRight", 5, 0 )

	frame:SetScript( "OnUpdate", m.on_update )
	frame:SetScript( "OnShow", function()
		RequestRaidInfo()
		m.delta = 1
	end )

	m.popup_frame = CreateFrame( "Frame", "TurtleCalendarDropDown", frame, "UIDropDownMenuTemplate" )
	m.popup_frame.initialize = m.popup_initialize

	return frame
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
				local sec_left = next - m.server_time
				local days, hours, min, sec = m.seconds_dhms( sec_left )

				box.days:SetText( string.format( "%02d", days ) )
				box.hours:SetText( string.format( "%02d", hours ) )
				box.min:SetText( string.format( "%02d", min ) )
				box.sec:SetText( string.format( "%02d", sec ) )

				box.time:SetPoint( "Center", box, "Center", 0, 0 )
				box.days:Show()
				box.label_days:Show()
				box.hours:Show()
				box.label_hours:Show()

				if m.db.condensed_timers then
					if days == 0 then
						local offset = 25
						box.days:Hide()
						box.label_days:Hide()

						if hours == 0 then
							box.hours:Hide()
							box.label_hours:Hide()
							offset = offset + 25
						end
						box.time:SetPoint( "Center", box, "Center", -offset, 0 )
					end
				end

				if m.db.show_dates then
					box.date:Show()
					box.date:SetText( date( m.db.date_format, time( date( "*t", next + m.time_offset ) ) ) )
				else
					box.date:Hide()
				end
				if box.data.id == "bg" then
					box.time:SetPoint( "Bottom", box, "Bottom", 0, m.db.show_dates and 65 or 55 )
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
			box.sub2:SetText( getn( m.db.instances ) == 0 and "No lockouts" or "" )
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

	for k, v in pairs( m.raids ) do
		local box = m.boxes[ v ]
		if m.instances[ k ] and box.is_visible then
			if v == "kara" or v == "ony" then
				m.boxes[ v ].sub1:SetText( string.format( "ID: |cffdddd00%s|r", m.instances[ k ].id ) )
			else
				box.inst_name:SetText( (box.inst_name:GetText() or "") .. k .. "\n" )
				box.inst_id:SetText( (box.inst_id:GetText() or "") .. m.instances[ k ].id .. "\n" )
			end
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
	m.boxes.bg.next_day:SetText( "Coming next day: " .. m.bgs[ bg_idx ].name )
	m.boxes.bg.next_bg:SetTexture( m.images[ "bg_" .. m.bgs[ bg_idx ].id ].image )

	-- Darkmoon Fair
	local dmf_idx = mod( math.floor( (m.sday - 3) / m.timers[ m.realm ][ "dmf" ].interval ), 2 ) + 1
	local now = date( "!*t", m.get_server_time() + m.time_offset )
	local dmf = dmf_idx == 1 and "Thunder Bluff" or "Goldshire"

	m.boxes.dmf.bg:SetTexture( m.images[ dmf ].image )
	if now.wday == 4 then
		m.boxes.dmf.header:SetText( "Day off" )
		m.boxes.dmf.sub1:SetText( "It will be back tomorrow" )
		m.boxes.dmf.sub2:SetText( "Stays at " .. dmf .. " until" )
	else
		m.boxes.dmf.header:SetText( dmf )
		m.boxes.dmf.sub1:SetText( "Darkmoon Faire position" )
		m.boxes.dmf.sub2:SetText( "Moves out every Sunday" )
	end

	m.reorder()
end

function TurtleCalendar.popup_menu()
	if arg1 == "RightButton" then
		m.popup_box = this.id
		ToggleDropDownMenu( 1, nil, m.popup_frame, "cursor", 0, 0 )
	end
end

function TurtleCalendar.popup_initialize()
	local function on_raid_click( arg1 )
		m.db.boxes[ arg1 ][ 2 ] = not this.checked
		m.reorder()
	end

	UIDropDownMenu_AddButton( { isTitle = true, notCheckable = true, text = "Global" } )
	UIDropDownMenu_AddButton( {
		text = "Condensed timers",
		keepShownOnClick = 1,
		checked = m.db.condensed_timers or false,
		func = function()
			m.db.condensed_timers = not this.checked
			m.delta = 1
		end
	} )
	UIDropDownMenu_AddButton( {
		text = "Show dates",
		keepShownOnClick = 1,
		checked = m.db.show_dates or false,
		func = function()
			m.db.show_dates = not this.checked
			m.delta = 1
		end
	} )
	UIDropDownMenu_AddButton( { isTitle = true, notCheckable = true, text = "Raids" } )

	local info = {
		func = on_raid_click,
		keepShownOnClick = 1
	}

	for i, box in ipairs( m.db.boxes ) do
		if i == 6 then
			UIDropDownMenu_AddButton( { isTitle = true, notCheckable = true, text = "Misc" } )
		end
		info.text = m.boxes[ box[ 1 ] ].data.name
		info.arg1 = i
		info.checked = m.boxes[ box[ 1 ] ].is_visible
		UIDropDownMenu_AddButton( info )
	end
end

function TurtleCalendar.reorder()
	-- This really needs refactoring
	local pos = 1
	local prev_box
	local line1
	local line2

	for i, box_info in ipairs( m.db.boxes ) do
		---@type BoxFrame
		local box = m.boxes[ box_info[ 1 ] ]

		box.set_visibility( box_info[ 2 ] )
		if box_info[ 2 ] then
			if i <= 5 then
				if pos == 1 then
					box:SetPoint( "TopLeft", m.popup, "TopLeft", 15, -35 )
					line1 = 1
				else
					box:SetPoint( "TopLeft", prev_box, "TopRight", 5, 0 )
					line1 = line1 + 1
				end
			else
				if not line2 then
					box:SetPoint( "TopLeft", m.popup, "TopLeft", 15, -(35 + 222 + 5) )
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
			m.popup:SetHeight( 460 )
			if line1 < 2 and line2 < 2 and m.db.boxes[ 8 ][ 2 ] then
				m.popup:SetWidth( 1070 - 209 - 209 - 209 - 209 )
			elseif line1 < 3 and line2 < 2 then
				m.popup:SetWidth( 1070 - 209 - 209 - 209 )
			elseif line1 < 5 and line2 < 3 then
				if line1 < 4 and (line2 < 2 or m.db.boxes[ 8 ][ 2 ]) then
					m.popup:SetWidth( 1070 - 209 - 209 )
				else
					m.popup:SetWidth( 1070 - 209 )
				end
			else
				m.popup:SetWidth( 1070 )
			end
		end
	else
		m.popup:SetHeight( 460 - 189 )
		m.popup:SetWidth( 25 + (line1 or 1) * 209 )
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
	local tag = string.format( "|c%s%s|r", m.tagcolor, short and "TC" or "TurtleCalendar" )
	DEFAULT_CHAT_FRAME:AddMessage( string.format( "%s: %s", tag, message ) )
end

---@param message string
function TurtleCalendar.debug( message )
	if m.debug_enabled then
		local tag = string.format( "|c%s%s|r", m.tagcolor, "TC" )
		DEFAULT_CHAT_FRAME:AddMessage( string.format( "%s: %s", tag, message ) )
	end
end

---@return integer seconds
---@nodiscard
function TurtleCalendar.get_server_time()
	local server_ts = time()
	server_ts = server_ts - m.time_offset

	return server_ts
end

---@return integer
function TurtleCalendar.server_day_number()
	local server_ts = TurtleCalendar.get_server_time()

	return math.floor( (server_ts + m.time_offset) / 86400 )
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

TurtleCalendar:init()
