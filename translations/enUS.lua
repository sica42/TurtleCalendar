TurtleCalendar = TurtleCalendar or {}

---@class TurtleCalendar
local m = TurtleCalendar
m.translations = m.translations or {}

m.T = setmetatable( (m.translations or {})[ GetLocale() or "enUS" ] or {}, {
	__index = function( tbl, key )
		local value = tostring( key )
		rawset( tbl, key, value )
		return value
	end
} )

m.translations[ "enUS" ] = {
	[ "YELL_TRIGGER_ALLIANCE_ONYXIA" ] = "The dread lady, Onyxia, hangs from the arches!",
	[ "YELL_TRIGGER_ALLIANCE_NEFARIAN" ] = "Citizens of the Alliance, the Lord of Blackrock is slain! Nefarian has been subdued",
	[ "YELL_TRIGGER_HORDE_ONYXIA" ] = "The brood mother, Onyxia, has been slain!",
	[ "YELL_TRIGGER_HORDE_NEFARIAN" ] = "NEFARIAN IS SLAIN! People of Orgrimmar, bow down before the might of",
	[ "Onyxia" ] = nil,
	[ "Nefarian" ] = nil,
	[ "Karazhan" ] = nil,
	[ "N/A" ] = nil,
	[ "Global" ] = nil,
	[ "Raids" ] = nil,
	[ "Misc" ] = nil,
	[ "Condensed timers" ] = nil,
	[ "Show timers" ] = nil,
	[ "Show dates" ] = nil,
	[ "Battleground" ] = nil,
	[ "Darkmoon faire" ] = nil,
	[ "Instances" ] = nil,
	[ "No lockouts" ] = nil,
	[ "World Buffs" ] = nil,
	[ "Stormwind buffs" ] = nil,
	[ "Orgrimmar buffs" ] = nil,
	[ "Raid" ] = nil,
	[ "Resets every %d days" ] = nil,
	[ "Zul'Gurub Edge of Madness" ] = nil,
	[ "BG of the day" ] = nil,
	[ "Coming next day: " ] = nil,
	[ "Thunder Bluff" ] = nil,
	[ "Goldshire" ] = nil,
	[ "Day off" ] = nil,
	[ "Resets every day" ] = nil,
	[ "It will be back tomorrow" ] = nil,
	[ "Stays at %s until" ] = nil,
	[ "Darkmoon Faire position" ] = nil,
	[ "Moves out every Sunday" ] = nil,
	[ "days" ] = nil,
	[ "hours" ] = nil,
	[ "min" ] = nil,
	[ "sec" ] = nil,
	[ "Left-click to toggle." ] = nil,
	[ "Toggle the calendar" ] = nil,
	[ "Alterac Valley" ] = nil,
	[ "Warsong Gulch" ] = nil,
	[ "Arathi Basin" ] = nil,
	[ "Blood Ring Arena" ] = nil,
	[ "Sunnyglade Valley" ] = nil,
	[ "Gri'lek" ] = nil,
	[ "Hazza'rah" ] = nil,
	[ "Renataki" ] = nil,
	[ "Wushoolay" ] = nil,
	[ "Molten Core" ] = nil,
	[ "Blackwing Lair" ] = nil,
	[ "Ahn'Qiraj Temple" ] = nil,
	[ "Naxxramas" ] = nil,
	[ "Emerald Sanctum" ] = nil,
	[ "Onyxia's Lair" ] = nil,
	[ "Lower Karazhan Halls" ] = nil,
	[ "Zul'Gurub" ] = nil,
	[ "Ruins of Ahn'Qiraj" ] = nil,
	[ "Powered by " ] = nil,
	[ "ID" ] = nil,
}
