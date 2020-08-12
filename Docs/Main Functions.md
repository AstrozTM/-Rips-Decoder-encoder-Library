## Main Functions

# Encode
```lua
<string> encode(variant <object,string>)
```
Example:
```lua
local S = Instace.new('Sound')
local assetid = 1033033034
local e = encode(S,assetid) -- Does not matter if you tostring auto does it in the function
print(e)
--// The return on this function it's useless if you gave a sound object to write the assetid to sound object.
```

# Decode
```lua
<string> decode(variant <assetid>)
```
Example:
```lua
local EncodedAssetId = loadstring(game:HttpGet('https://pastebin.com/raw/7ZggHq7Y',true)()
local d = decode(EncodedAssetId)
print(d)
```