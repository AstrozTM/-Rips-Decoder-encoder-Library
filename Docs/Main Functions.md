## Main Functions

# Encode
```lua
<string> encode(variant <string, Instance>)
```
This Encodes any assetid but it's more used for (Sound Ids)
If you specify a sound Instance it writes it to the Sound object.
<br>
Example:
```lua
local S = Instace.new('Sound')
local assetid = 1033033034
local e = encode(S,assetid) -- Does not matter if you tostring auto does it in the function
print(e)
```

# Decode
```lua
<string> decode(variant <string>)
```
This decodes any Encoded AssetId (Rip's/dot.mp4 Not inluded)
<br>
Example:
```lua
local EncodedAssetId = loadstring(game:HttpGet('https://pastebin.com/raw/7ZggHq7Y',true)()
local d = decode(EncodedAssetId)
print(d)
```

# Verify
```lua
<string> verify(variant <string>)
```
This can be used to verify this is optional since the user can always use the one provided here (https://discord.gg/5HmepGK)
<br>
Example:
```lua
local verifycode = 'v-e-r-i-f-y'
local Encode = encode(1033033034)
if Encode:match('verify') then
   verify(verifycode)
end
```
