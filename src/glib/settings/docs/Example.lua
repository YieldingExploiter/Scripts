local slib = loadstring(game:HttpGetAsync('https://raw.githubusercontent.com/YieldingExploiter/Scripts/main/dist/glib/settings/Script.lua',true))()
local Settings = slib.new('Example-a29fdsakljhv7xcnqic')
Settings:Set('Boolean',true)
Settings:Set('String','something lmao')
Settings:Set('UserSettings.SavedPositions',{{['x']=0;['y']=0;['z']=0;};{['x']=0;['y']=666;['z']=0;}}):Set('UserSettings.AgreedToTerms',true)
print(Settings:Get('Boolean')) --> true
print(Settings:Get('UserSettings.AgreedToTerms')) --> true
Settings:Ensure('UserSettings.AgreedToTerms',false)
print(Settings:Get('UserSettings.AgreedToTerms')) --> true
Settings:Ensure('Feedback.IsSlibGood',1)
print(Settings:Get('Feedback.IsSlibGood')) --> 1
