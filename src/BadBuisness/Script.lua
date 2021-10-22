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

local SettingsLib = loadstring(
  game:HttpGetAsync(
    'https://raw.githubusercontent.com/YieldingExploiter/Scripts/main/dist/glib/settings/Script.lua',
    true
  )
)()
local Settings = SettingsLib.new('BadBuisness')

loadstring(game:HttpGetAsync(('https://raw.githubusercontent.com/Straden/Scripts/main/BadBuisness.lua'),true))()
