-- This script only contains the UI portions and a loader for the Bad Buisness Script.
print(
  [[
  ---- Bad Buisness 2.48
  | Original Script   | https://v3rmillion.net/showthread.php?tid=1141282                                   |

  Credits
  | Original Script   | Throit                                                                              |
  | UI                | YieldingCoder                                                                       |
  
  Source Code
  | Script            | https://github.com/YieldingExploiter/Scripts/blob/main/src/BadBuisness/Script.lua   |
  | Discord UI        | https://github.com/YieldingExploiter/Scripts/tree/main/src/ui/dlib.lua              |
]]
)

local versionInfo = {
  ['Branch'] = 'Stable';
  ['Version'] = '0.1.0';
  ['Build'] = '00001';
  ['Hash'] = '5c8edf2'; -- Last Git hash seen on https://github.com/YieldingExploiter/Scripts/tree/main/src/BadBuisness at the time of last source modification.
  ['LastTested'] = 1139; -- Last version the script was tested on
}

local SettingsLib = loadstring(
  game:HttpGetAsync(
    'https://raw.githubusercontent.com/YieldingExploiter/Scripts/main/dist/glib/settings/Script.lua',
    true
  )
)()
local Settings = SettingsLib.new('BadBuisness')

local tableToColor3 = function( inTable )
  return Color3.fromRGB(inTable.R, inTable.G, inTable.B)
end
local color3ToTable = function( inClr3 )
  return { ['R'] = inClr3.R * 255; ['G'] = inClr3.G * 255; ['B'] = inClr3.B * 255 }
end

_G.BBconfig = {
  -- ANCHOR espColor = BBConfig.ESP.Clr
  espColor = tableToColor3(
    Settings:Default(
      'BBConfig.ESP.Clr', color3ToTable(Color3.new(1, 0, 0))
    ):Get('BBConfig.ESP.Clr')
  );
  -- ANCHOR fovColor = BBConfig.FOV.Clr
  fovColor = tableToColor3(
    Settings:Default(
      'BBConfig.FOV.Clr', color3ToTable(Color3.fromRGB(255, 255, 255))
    ):Get('BBConfig.FOV.Clr')
  );
  fovTransparency = Settings:Default('BBConfig.FOV.Transparency', 0.7):Get(
    'BBConfig.FOV.Transparency'
  );
  -- ANCHOR fovAmount = BBConfig.FOV.Amnt
  fovAmount = Settings:Default('BBConfig.FOV.Amnt', 300):Get('BBConfig.FOV.Amnt');
  -- ANCHOR aimbotSmoothness = BBConfig.Aimbot.Smoothness
  aimbotSmoothness = Settings:Default('BBConfig.Aimbot.Smoothness', 2):Get(
    'BBConfig.Aimbot.Smoothness'
  );
  -- ANCHOR flySpeed = BBConfig.Fly.Speed
  flySpeed = Settings:Default('BBConfig.Fly.Speed', 90):Get('BBConfig.Fly.Speed');
}

local LoadInternal = loadstring(
  game:HttpGetAsync(
    -- TODO: Minify and use dist dir
    ('https://github.com/YieldingExploiter/Scripts/blob/main/src/BadBuisness/Internal.lua?raw=true'),
    true
  )
)

local DiscordLib = loadstring(
  game:HttpGetAsync(
    'https://raw.githubusercontent.com/YieldingExploiter/Scripts/main/dist/ui/dlib.lua',
    true
  )
)()

local win = DiscordLib:Window('Discock', versionInfo)
if game.PlaceId ~= 3233893879 then return end
local Server = win:Server('Bad Buisness Script', '')
if game.PlaceVersion > versionInfo.LastTested then
  local Outdated = Server:Channel('Outdated Script')
  Outdated:Label(
    'This script was last tested on Game Version ' .. tostring(versionInfo.LastTested)
  )
  Outdated:Label('The current Game Version is ' .. tostring(game.PlaceVersion))
  Outdated:Label('As you can tell, this is not that cool and sex')
  Outdated:Seperator();
  Outdated:Label('tl;dr:')
  Outdated:Label('the script might not work and might be detected')
end

local ESP = Server:Channel('ESP')
ESP:Colorpicker(
  'ESP Color', tableToColor3(Settings:Get('BBConfig.ESP.Clr')), function( new )
    Settings:Set('BBConfig.ESP.Clr', color3ToTable(new))
    _G.BBconfig.espColor = new
  end
)
local FOV = Server:Channel('FOV')
FOV:Colorpicker(
  'FOV Color', tableToColor3(Settings:Get('BBConfig.FOV.Clr')), function( new )
    Settings:Set('BBConfig.FOV.Clr', color3ToTable(new))
    _G.BBconfig.fovColor = new
  end
)
FOV:Slider(
  'FOV Opacity', 0, 800, Settings:Get('BBConfig.FOV.Transparency') * 1000, function( new )
    new = new / 1000
    Settings:Set('BBConfig.FOV.Transparency', new)
    _G.BBconfig.fovTransparency = new
  end
)
FOV:Slider(
  'FOV Amount', 0, 1000, Settings:Get('BBConfig.FOV.Amnt'), function( new )
    Settings:Set('BBConfig.FOV.Amnt', new)
    _G.BBconfig.fovAmount = new
  end
)
local Aimbot = Server:Channel('Aimbot')
Aimbot:Slider(
  'Smoothness', 0, 10, Settings:Get('BBConfig.Aimbot.Smoothness'), function( new )
    Settings:Set('BBConfig.Aimbot.Smoothness', new)
    _G.BBconfig.aimbotSmoothness = new
  end
)
local Fly = Server:Channel('Fly')
Fly:Slider(
  'Speed', 0, 250, Settings:Get('BBConfig.Fly.Speed'), function( new )
    Settings:Set('BBConfig.Fly.Speed', new)
    _G.BBconfig.flySpeed = new
  end
)
Fly:Label('Fly Keybind is F')
Fly:Label('(might add rebinding later)')
LoadInternal()()
