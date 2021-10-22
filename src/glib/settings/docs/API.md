# API

## Settings Class
To create a new `Settings` Class, use `SettingsLib.new("YOURSCRIPTNAME")`. If your Script's Name is common, add an identifier to it. <br/>
Changing the Name resets the Config.

### Self-Explanatory Methods
`Get(k)` -> `any`
`Set(k,v)` -> `<Settings> self`

### Methods
#### `Ensure(k,d)` -> `<Settings> self` 
If there is no data for key `k`, set it to `d`.
