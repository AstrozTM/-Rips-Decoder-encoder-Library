## Custom Functions

# Table Encode
```lua
<table> encoedetable(variant <table>)
```
This is unlike the Main Encode function, This one encodes all sound instances or strings on a table!
<br>
Example:
```lua
local TableToSearch = {'2733053836'}
local EncodedTable = encodedtable(TableToSearch)
for i,v in pairs(EncodedTable) do
 local sound = Instance.new('Sound')
 sound.SoundId = v
 sound:Play()
 break
end
```

# Table Decode
```lua
<table> decodetable(variant <table>)
```
This is unlike the Main Decode function,This one decodes all sound instances or strings on a table!
<br>
Example:
```lua
local TableToSearch = game.Workspace:GetDescendants()
local decodedTable = decodedtable(TableToSearch)
for i,v in pairs(decodedTable) do
 print(v)
 break
end
```

# Find Users
```lua
<table> findusers(<void>)
```
This finds users using this library
<br>
Example:
```lua
local Users = findusers()
for i,v in pairs(Users) do
  print(v.Name)
end
```

# Hide
```
<void> hide(<void>)
```
This hides you when your using this library
