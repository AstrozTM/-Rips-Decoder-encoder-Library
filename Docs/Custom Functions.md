## Custom Functions

# Table Decode
```lua
<table> encodetable(variant <table>)
```
This is unlike the Main Decode function,This one decodes all sound objects on a table!
Example:
```lua
local TableToSearch = game.Workspace:GetDescendants()
local decodedTable = encodetable(TableToSearch)
```
