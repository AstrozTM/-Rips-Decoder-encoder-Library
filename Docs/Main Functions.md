## Main Functions

# Encode AssetId
```lua
return encode(variant <object,string>)
```
Example:
```lua
local S = Instace.new('Sound')
local assetid = 1033033034
encode(S,assetid) -- Does not matter if you tostring auto does it in the function
--// The return on this function it's useless if you gave a sound object to write the assetid to sound object.
```

# Decode AssetId
```lua
decode(variant <assetid>)
```
Example:
```lua
local EncodedAssetId = loadstring(game:HttpGet('https://pastebin.com/raw/7ZggHq7Y',true)()
decode(EncodedAssetId)
```
