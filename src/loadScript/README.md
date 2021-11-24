# LoadScript
Creates a fake script in instance `location` with children `children`, with contents `url`. The script doesn't actully exist, but this creates a table that acts like a real script.

## How to use it
call `LoadScript(URL,script,{})`

(`LoadScript(URL,Location,Children)`)

## Requirements
- `game:HttpGetAsync()`
- `loadstring()`
