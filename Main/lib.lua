--// Rips Decoder/encoder made by Astroz and Rip \\--
  --// Settings \\--
  local Request
  local RequestList = {
    syn,
    request,
    http_request
  }
--// To Ignore \\--
 --// Urls \\--
  local durl = 'https://riptxde.dev/audio-logger-v2.php'
  local eurl = 'https://riptxde.dev/anti-logger-v2a.php?mode=false&id='
  local rurl = 'http://www.roblox.com/asset/?id='
  local vurl = 'https://riptxde.dev/auth.php?verification-code='
--// Request Setup \\--
for i,v in pairs(RequestList) do
   if v ~= nil then
      Request = v
      else
      return "Http method not found maybe it's not listed please list the function"
   end
end

function UrlEncode(s)
 local urlencoded game:GetService('HttpService'):UrlEncode(s)
 return urlencode
end
--// Encode Function \\--
getgenv().encode = function(AssetID,SoundObject)
 if AssetID ~= nil then
    local IS = game:GetService('InsertService')
    local m = IS:LoadAsset(tonumber(AssetID))
    if m ~= nil then
    local encodedid = Request({Url = url..UrlEncode(tostring(AssetId)); Method = 'GET'})['Body']
    if encodedid:match('^Notice: New location detected') then
     return 'Check your gmail for a verify code and if this has a verify function use it else use rips gui to verify thanks'
     elseif encodedid:match('^Error: ') then
     return encodedid
    end
    wait(.8)
    if SoundObject ~= nil  then
    SoundObject.SoundId = encodedid
    end
    return encodedid
else
    return 'The AssetID is not a valid one.'
end
    end
   else
   return 'Please Specify the ID'
 end
end

--// Decode \\--
  getgenv().decode = function(AssetID)
	local arg = tostring(AssetID):gsub('%s',''):lower()
	if not arg:match('^http://www.roblox.com/asset/%?id=' and not arg:match('^https://www.roblox.com/asset/%?id=') and not arg:match('^rbxassetid://') then
		AssetID = rurl..tostring(AssetID)
	end
	local decodedid = Request({
		Body = 'soundid='..UrlEncode(AssetID);
		Url = durl;
		Method = 'POST';
	})['Body']
    if decodedid:match('^Notice: New location detected') then
     return 'Check your gmail for a verify code and if this has a verify function use it else use rips gui to verify thanks')
     elseif decodedid:match('^Error: ') then
     return decodedid
    end
    wait(.8)
    return decodedid
  end

--// Encode Table Function \\--
getgenv().encodetable = function(T)
 local TableReturn = {}
 for i,v in pairs(T) do
   if v:IsA('Sound') then
      local id = decode(v.SoundId)
      local encodedid = encode(id)
      local encodedid encode(v)
      TableReturn[#TableReturn+1] = encodedid
   else
    local encodedid encode(v)
    TableReturn[#TableReturn+1] = encodedid
    end
   end 
   return TableReturn
end    
 
  --// Decode Table \\--
  getgenv().decodetable() = function(T)
   local TableReturn = {}
     for i,v in pairs(T) do
       if v:IsA('Sound') then
         local decodedid = decode(v.SoundId)
         return decodedid
         else
         local decodedid = decode(v)
         return decodedid
       end
     end
   end
  --// Verify \\--
getgenv().verify = function(Code)
  if Code ~= nil and Code ~= '' then
    local ReturnResponce = Request({
		Body = 'soundid='..Escape(AssetId);
		Url = 'https://riptxde.dev/audio-logger-v2.php';
		Method = 'POST';
	})['Body']
    return ReturnResponce
  end
end
