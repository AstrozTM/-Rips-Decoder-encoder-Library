## Custom Functions

# Table Decode
```lua
<table> decodetable(variant <table>)
```
This is unlike the Main Decode function,This one decodes all sound objects on a table!
<br>
Example:
```lua
local TableToSearch = game.Workspace:GetDescendants()
local decodedTable = encodetable(TableToSearch)
for i,v in pairs(decodedTable) do
 print(v)
 break
end
```
