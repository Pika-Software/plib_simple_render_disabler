local cam_Start2D = cam.Start2D
local cam_End2D = cam.End2D
local surface = surface

local addonName = 'Simple Render Disabler'

surface.CreateFont(addonName, {
	['font'] = 'Roboto',
	['size'] = 24,
	['weight'] = 800,
	['extended'] = true
})

do

	local w, h = ScrW(), ScrH()
	hook.Add('ScreenResolutionChanged', addonName, function( newW, newH )
		w, h = newW, newH
	end)

	local status = system.HasFocus()
	hook.Add('SystemFocusChanged', addonName, function( newStatus )
		status = newStatus
	end)

	local enable = CreateClientConVar( 'cl_render_disabler', '1', true, true, ' - ', 0, 1 )
	local text = 'Render is disabled.'

	hook.Add('RenderScene', addonName, function()
		if enable:GetBool() then
			if status then return end

			cam_Start2D()
				surface.SetTextColor( 255, 255, 255 )
				surface.SetFont( addonName )
				local tw, th = surface.GetTextSize( text )
				surface.SetTextPos( (w - tw) / 2, (h - th) / 2 )
				surface.DrawText( text )
			cam_End2D()

			return true
		end
	end)

end