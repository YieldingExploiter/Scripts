-- discordLibAdapter is a simple Adapter for the Windows 11 UI Library allowing usage of the Discord UI Library functions (atleast a significant portion of them)
-- This was made more as an experiment, not a final product.
-- How to use custom Win11Libs: Set DiscordAdapter.WinLib to the actual library before calling DiscordAdapter:Window()
local DiscordAdapter = {}

DiscordAdapter.WinLib = loadstring(
  game:HttpGetAsync(
    'https://raw.githubusercontent.com/YieldingExploiter/Scripts/main/dist/ui/dlib.lua',
    true
  )
)()

function DiscordAdapter:Window( name, versionInfo )
  local WinLib = DiscordAdapter.WinLib
  local Window = setmetatable(
    {}, {
      __index = function( t, k )
        error(
          'DiscordAdapter/Win11Lib: UnimplementedException for proprety/method: ' .. k ..
            '\nPlease report this to YieldingCoder!'
        )
      end;
    }
  )
  local _Win11Window = WinLib.createMenu(
    name, Enum.KeyCode.World0, true, 1200, 600, '',
    game:GetService('Players').LocalPlayer.Character, 'Exploiter'
  )
  _Win11Window.GetSavingInstance(
    'win11.discordAdapter.' .. name .. '.' .. game.GameId .. '-' .. game.PlaceId
  )

  Window._Win11 = _Win11Window

  local isFirst = true;
  local i = 0;
  function Window:Server( name, iconid )
    local _Win11Server = _Win11Window.addTab(
      name, 'n.' .. name .. '-i' .. iconid, isFirst, iconid
    )
    isFirst = false;

    local Server = setmetatable(
      {}, {
        __index = function( t, k )
          error(
            'DiscordAdapter/Win11Lib: UnimplementedException for proprety/method: ' .. k ..
              '\nPlease report this to YieldingCoder!'
          )
        end;
      }
    )
    -- ANCHOR Label
    -- NOTE Is Workaround: Toggle
    function Server:Label( text, description )
      i = i + 1
      warn(
        'DiscordAdapter/Win11Lib: UnimplementedException for proprety/method: Label' ..
          '\nUsing workaround: Toggle'
      )
      _Win11Server.addToggle(
        text, text .. i, description or
          'This is a label workaround, and therefor the switch does nothing.', false,
        function() end
      )
    end

    local tableToColor3 = function( inTable )
      return Color3.fromRGB(inTable.R, inTable.G, inTable.B)
    end
    local color3ToTable = function( inClr3 )
      return { ['R'] = inClr3.R * 255; ['G'] = inClr3.G * 255; ['B'] = inClr3.B * 255 }
    end
    -- ANCHOR ColorPicker
    -- NOTE Is Workaround: Individual Color Channels
    function Server:Colorpicker( name, value, updatecb )
      i = i + 1
      warn(
        'DiscordAdapter/Win11Lib: UnimplementedException for proprety/method: Colorpicker' ..
          '\nUsing workaround: Individual r/g/b sliders.'
      )
      local CurrentValue = color3ToTable(value or Color3.new(0, 0, 0))
      updatecb = updatecb or function( x ) end
      _Win11Server.addSlider(
        name, name .. i .. '-R', 0, 255, CurrentValue.R * 255, false,
        'The red color channel for the Color Picker ' .. name, '', function( newR )
          CurrentValue.R = newR;
          updatecb(tableToColor3(CurrentValue))
        end
      )
      _Win11Server.addSlider(
        name, name .. i .. '-G', 0, 255, CurrentValue.G * 255, false,
        'The green color channel for the Color Picker ' .. name, '', function( newG )
          CurrentValue.G = newG;
          updatecb(tableToColor3(CurrentValue))
        end
      )
      _Win11Server.addSlider(
        name, name .. i .. '-B', 0, 255, CurrentValue.G * 255, false,
        'The blue color channel for the Color Picker ' .. name, '', function( newB )
          CurrentValue.B = newB;
          updatecb(tableToColor3(CurrentValue))
        end
      )
    end

    -- ANCHOR Slider
    function Server:Slider( name, min, max, default, updatecb )
      i = i + 1
      local isPrecise = not (min % 1 == 0 and max % 1 == 0 and default % 1 == 0)
      _Win11Server.addSlider(name, name .. i, min, max, default, isPrecise, updatecb)
    end

    return Server
  end

  return Window
end

return DiscordAdapter
