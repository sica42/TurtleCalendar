TurtleCalendar = TurtleCalendar or {}

---@class TurtleCalendar
local m = TurtleCalendar

if m.MinimapIcon then return end

---@class MinimapIcon
---@field icon table

local M = {}

function M.new()
	local ldb = LibStub:GetLibrary( "LibDataBroker-1.1" )
	local icon = LibStub:GetLibrary( "LibDBIcon-1.0" )

	local data = {
		type = "data source",
		label = m.name,
		icon = "Interface\\AddOns\\TurtleCalendar\\assets\\icon.tga",
		tocname = m.name
	}

	local obj = ldb:NewDataObject( "Broker_TurtleCalendar", data ) ---[[@as LibDataBroker.DataDisplay]]

	function obj.OnTooltipShow( self )
		self:AddLine( "TurtleCalendar" )
		self:AddLine( m.T["Left-click to toggle."], 0.5, 0.5, 0.5 )
	end

	function obj:OnClick( button )
		if button == "LeftButton" then
			m.toggle()
		end
	end

	icon:Register( m.name, obj, m.db.minimap_icon )

	---@type MinimapIcon
	return {
		icon = icon
	}
end

m.MinimapIcon = M
return M
