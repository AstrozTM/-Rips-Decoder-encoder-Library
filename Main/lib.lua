--// RIPS Encoder/Decoder \\--
 --// Settings \\--
 local Request
 local RequestList = {
  syn.request,
  request,
  http_request
}
--// URLS \\--
local Url_D = 'https://riptxde.dev/audio-logger-v2.php'
local Url_E = 'https://riptxde.dev/anti-logger-v2a.php?mode=false&id='
local Url_R = 'http://www.roblox.com/asset/?id='
local Url_V = 'https://riptxde.dev/auth.php?verification-code='
local Url_N = 'https://riptxde.dev/anti-logger-v2a.php?mode=true&id='
--// Error Msgs \\--
local New_Login = 'New login detected Check your gmail'
--// SHORTEND URL ENCODE \\--
local UE = function(s)
  if not s ~= nil and not type(s) == 'string' then
    return 'Invalid Args'
  end  
   return game:GetService("HttpService"):UrlEncode(s)
end  
--// REQUEST SETUP \\--
for i,v in pairs(RequestList) do
  if v ~= nil and type(v) == 'function' then
    Request = v
  end
end  
--// ENCODE \\--
getgenv().encode = function(id,SoundObject)
   if not id ~= nil then return "AssetId Can't be emty" end
   id = tostring(id)
   local ProcessedId = Request({
     Url = Url_E .. UE(id);
     Method = 'GET'
   })['Body']
   --// Making sure the ProcessedId isn't an error \\--
   if ProcessedId:match('^Notice: N') then return New_Login end
   if ProcessedId:match('^Error: ') then return ProcessedId end
        Request({
          Url = Url_N .. UE(id);
          Method = 'GET';
        })['Body']
        wait(.1)
        if not SoundObject ~= nil then return ProcessedId end
        SoundObject.SoundId = ProcessedId
        return ProcessedId
end  
--// DECODE \\--
getgenv().decode = function(id)
  local a=tostring(AssetID):gsub('%s',''):lower()if not a:match('^http://www.roblox.com/asset/%?id=')and not a:match('^https://www.roblox.com/asset/%?id=')and not a:match('^rbxassetid://')then id=Url_R..tostring(id)end
  local ProcessedId = Request({
    Url = 'soundid' .. id;
    Method = 'POST';
  })['Body']
  if #ProcessedId < 1 then return 'Invalid Parse' end
  if ProcessedId:match('^Notice: N') then return New_Login end
   if ProcessedId:match('^Error: ') then return ProcessedId end
   return ProcessedId
end 
--// VERIFY \\--
getgenv().verify = function(Code)
    if not Code ~= nil then return "Code Can't be emty" end
    local Msg = Request({
      Url = Url_V .. Code;
      Method = 'GET';
    })['Body']
    return Msg
end 
--// ENCODE TABLE \\--
getgenv().encodetable = function(T)
  local ReturnT
  for i,v in pairs(T) do
     if v:IsA('Sound') then
        local url1 = '^http://www.roblox.com/asset/%?id='
        local url2 = '^https://www.roblox.com/asset/%?id='
        local url3 = '^rbxassetid://'
        local Id = Sound.SoundId
        if Id:match(url1) then Id = Id:sub(#url1) end
        if Id:match(url2) then Id = Id:sub(#url2) end
        if Id:match(url3) then Id = Id:sub(#url3) end
        ReturnT[#ReturnT+1] = encode(Id)
     else
      ReturnT[#ReturnT+1] = encode(v)
     end 
  end
  return ReturnT
end  
--// DECODE TABLE \\--
getgenv().decodetable = function(T)
   local ReturnT
   for i,v in (T) do
      if v:IsA('Sound') then
        ReturnT[#ReturnT+1] = decode(v.SoundId)
      else
        ReturnT[#ReturnT+1] = decode(v)
      end  
   end 
   return  ReturnT
end  
