local CustomMessage = 'Fuck you.'

local Request; if syn ~= nil then
	Request = syn.request
elseif request ~= nil then
	Request = request
elseif http_request ~= nil then
	Request = http_request
end

local UI, Origin = game:GetObjects('rbxassetid://5344970025&version=39')[1]; UI['Parent'] = game:GetService('CoreGui')

local Main, Notification, Control, Default, C = UI['Main-Frame'], UI['Notification'], UI['Minimize/Close'], Color3.fromRGB(217,60,56), {}

local CBackground, CImage, CText, CScroll = {}, {}, {}, {}

local Cast = {
	BackgroundColor3 = CBackground;
	ImageColor3 = CImage;
	TextColor3 = CText;
	ScrollBarImageColor3 = CScroll;
}

for A,B in next, UI:GetDescendants() do
	for C,D in next, Cast do
		coroutine.resume(coroutine.create(function()
			if tostring(B[C]) == tostring(Default) then
				D[#D+1] = B;
			end
		end))
	end
end

local Menu, Sectors = Main['Main-Menu'], Main['Sector-Holder']

local Dashboard = Sectors['Home']

local Tabs, TMenu = Dashboard['Tab-Frame']['Tab-Holder'], Dashboard['Tab-Menu']

Notification['Parent'] = game:GetService('CorePackages'); Notification['Main-Frame'].Position = UDim2.new(1.036,0,.753,0)

local Tween = function(Obj,Time,Style,Direction,Table)
	game:GetService('TweenService'):Create(Obj,TweenInfo.new(Time,Enum.EasingStyle[Style],Enum.EasingDirection[Direction],0,false,0),Table):Play()
end

Main['Position'] = Main['Position'] + UDim2.new(-1,0,0,0); Origin = Main['Position']; Tween(Main,.6,'Quad','Out',{Position = Main['Position'] + UDim2.new(1,0,0,0)})
Control['Position'] = Control['Position'] + UDim2.new(-1,0,0,0); Tween(Control,.6,'Quad','Out',{Position = Control['Position'] + UDim2.new(1,0,0,0)})

local Push = Instance.new('BindableEvent')

local Notify = function(Text,Duration)
	Duration = Duration or 4
	coroutine.wrap(function()
		local Clone = Notification:Clone(); local Frame = Clone['Main-Frame']; Clone['Parent'] = game:GetService('CoreGui'); Frame['TextBox'].Text = Text
		Push:Fire()
		local Event = Push['Event']:Connect(function()
			Tween(Frame,.4,'Quad','InOut',{Position = Frame['Position'] + UDim2.new(0,0,-.121,0)})
		end)
		Tween(Frame,.4,'Quad','InOut',{Position = UDim2.new(.8707,0,.753,0)}); wait(Duration + .4); Tween(Frame,.4,'Quad','InOut',{Position = UDim2.new(1.036,0,.753,0)}); wait(.4)
		Clone:Destroy(); Event:Disconnect()
	end)()
end

coroutine.wrap(function()
	wait(1.6)
	game:GetService('UserInputService')['InputBegan']:Wait()
	Notify('._ Boombox-Hub Loaded: discord.gg/5HmepGK for support.',4)
end)()

local Debounce = true

local Draggable = function(Frame)
	local DToggle, DInput, DStart, SPos
	local Upd = function(Input)
		if Debounce then
			Delta = Input['Position'] - DStart; Prime = UDim2.new(SPos['X'].Scale, SPos['X'].Offset + Delta['X'], SPos['Y'].Scale, SPos['Y'].Offset + Delta['Y'])
			Tween(Frame,.06,'Sine','Out',{Position = Prime})
		end
	end
	C[#C+1] = Frame['InputBegan']:Connect(function(Input)
		if (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) then
			DToggle = true
			DStart = Input.Position
			SPos = Frame.Position
			C[#C+1] = Input['Changed']:Connect(function()
				if (Input.UserInputState == Enum.UserInputState.End) then
					DToggle = false
				end
			end)
		end
	end)
	C[#C+1] = Frame['InputChanged']:Connect(function(Input)
		if (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
			DInput = Input
		end
	end)
	C[#C+1] = game:GetService('UserInputService').InputChanged:Connect(function(Input)
		if (Input == DInput and DToggle) then
			Upd(Input)
		end
	end)
end

Draggable(Main); Draggable(Control)

local MSelected = Menu['Home']

local MNavigate, TNavigate = function(Button,Y)
	C[#C+1] = Button['MouseButton1Click']:Connect(function()
		if Debounce then
			Debounce, MSelected = false, Button
			local T = Menu:GetChildren(); for I = 1,#T do local V = T[I]
				if V:IsA('TextButton') then
					if V ~= Button then
						if table.find(CText,V) then
							table.remove(CText,table.find(CText,V))
						end
						Tween(V,.3,'Quint','InOut',{TextColor3 = Color3.fromRGB(100,100,100)})
					else
						CText[#CText+1] = V
						Tween(V,.3,'Quint','InOut',{TextColor3 = Default})
					end
				end
			end
			Tween(Sectors,.6,'Quad','InOut',{Position = UDim2.new(0,0,Y,0)}); wait(.6)
			Debounce = true
		end
	end)
	C[#C+1] = Button['MouseEnter']:Connect(function()
		if MSelected ~= Button then
			Tween(Button,.3,'Quint','InOut',{TextColor3 = Color3.fromRGB(170,170,170)})
		end
		Button['MouseLeave']:Wait()
		if MSelected ~= Button then
			Tween(Button,.3,'Quint','InOut',{TextColor3 = Color3.fromRGB(100,100,100)})
		end
	end)
end, function(Button,X)
	C[#C+1] = Button['MouseButton1Click']:Connect(function()
		if Debounce then
			Debounce = false
			local Offset; if Button == TMenu['Scripts'] then
				Offset = .03
			elseif Button == TMenu['Anti-Logger'] then
				Offset = .068
			else
				Offset = .076
			end
			Tween(TMenu['Selector'],.4,'Quint','InOut',{Position = Button['Position'] + UDim2.new(Offset,0,.774,0)})
			Tween(Tabs,.6,'Quad','InOut',{Position = UDim2.new(X,0,0,0)}); wait(.6)
			Debounce = true
		end
	end)
	C[#C+1] = Button['MouseEnter']:Connect(function()
		Tween(Button,.3,'Quint','InOut',{TextColor3 = Color3.fromRGB(200,200,200)})
		Button['MouseLeave']:Wait()
		Tween(Button,.3,'Quint','InOut',{TextColor3 = Color3.fromRGB(120,120,120)})
	end)
end

MNavigate(Menu['Home'],0); MNavigate(Menu['Settings'],-1); MNavigate(Menu['Help'],-2); TNavigate(TMenu['Audio-Logger'],0); TNavigate(TMenu['Asset-Decoder'],-1); TNavigate(TMenu['Anti-Logger'],-2); TNavigate(TMenu['Scripts'],-3)

local RArg, RButton, CId, CButton = 'PlaySong', Sectors['Settings']['Boombox-Type']['Standard']

local AddFunc = function(Type,Button,Func)
	if Type == 'Main' then
		local IColor, TColor = Button['Parent'].ImageColor3, Button['TextColor3']
		C[#C+1] = Button['MouseButton1Click']:Connect(function()
			coroutine.wrap(Func)()
			Tween(Button['Parent'],.03,'Sine','Out',{ImageColor3 = Color3.fromRGB(22, 24, 27)}); wait(.03)
			Tween(Button['Parent'],.6,'Sine','Out',{ImageColor3 = IColor})
		end)
		C[#C+1] = Button['MouseEnter']:Connect(function()
			Tween(Button,.3,'Quint','InOut',{TextColor3 = Default})
			Button['MouseLeave']:Wait()
			Tween(Button,.3,'Quint','InOut',{TextColor3 = TColor})
		end)
	elseif Type == 'Sounds' then
		local IColor, TColor = Button['Frame'].ImageColor3, Button['TextColor3']
		C[#C+1] = Button['MouseButton1Click']:Connect(function()
			coroutine.wrap(Func)()
			Tween(Button['Frame'],.2,'Back','InOut',{ImageColor3 = Color3.fromRGB(22, 24, 27)})
			SObject, CId, CButton = Button['Sound'].Value, Button['Sound'].Value['SoundId'], Button
			local T = Button['Parent']:GetChildren(); for I = 1,#T do local V = T[I]
				if V ~= CButton and not V:IsA('UIListLayout') then
					Tween(V['Frame'],.2,'Quad','InOut',{ImageColor3 = Color3.fromRGB(33, 37, 41)})
				end
			end
		end)
		C[#C+1] = Button['MouseEnter']:Connect(function()
			Tween(Button,.3,'Quint','InOut',{TextColor3 = Default})
			Button['MouseLeave']:Wait()
			Tween(Button,.3,'Quint','InOut',{TextColor3 = TColor})
		end)
	elseif Type == 'Types' then
		local IColor, TColor = Button['Frame'].ImageColor3, Button['TextColor3']
		C[#C+1] = Button['MouseButton1Click']:Connect(function()
			coroutine.wrap(Func)()
			Tween(Button['Frame'],.2,'Back','InOut',{ImageColor3 = Color3.fromRGB(22, 24, 27)})
			RButton = Button
			local T = Button['Parent']:GetChildren(); for I = 1,#T do local V = T[I]
				if V ~= RButton then
					Tween(V['Frame'],.2,'Quad','InOut',{ImageColor3 = Color3.fromRGB(33, 37, 41)})
				end
			end
		end)
		C[#C+1] = Button['MouseEnter']:Connect(function()
			Tween(Button,.3,'Quint','InOut',{TextColor3 = Default})
			Button['MouseLeave']:Wait()
			Tween(Button,.3,'Quint','InOut',{TextColor3 = TColor})
		end)
	end
end

local Logger, Decoder, AntiLog = Tabs['Audio-Logger'], Tabs['Asset-Decoder'], Tabs['Anti-Logger']; local Logged = Logger['Logged-Sounds']; local Template = Logged['TextButton']; Template['Parent'] = game:GetService('CorePackages'); Logged['UIListLayout'].Padding = UDim.new(0,5)

local Ignore = {
'rbxasset://sounds/action_footsteps_plastic.mp3';
'rbxasset://sounds/impact_water.mp3';
'rbxasset://sounds/uuhhh.mp3';
'rbxasset://sounds/action_swim.mp3';
'rbxasset://sounds/action_get_up.mp3';
'rbxasset://sounds/action_falling.mp3';
'rbxasset://sounds/action_jump.mp3';
'rbxasset://sounds/action_jump_land.mp3';
}

local Sounds, IdSet, LToggle, Listening = {}, {}, false; Sounds.__mode = 'k'

AddFunc('Main',Logger['Copy ID'].TextButton, function()
	if CId then
		setclipboard(CId); Notify('Successfully set raw asset-id to clipboard.',4)
	end
end)

AddFunc('Main',Logger['Write ID To File'].TextButton, function()
	if CId then
		if not isfolder('RH-LoggedIds') then
			makefolder('RH-LoggedIds')
		end
		writefile('RH-LoggedIds/Id-'..(#listfiles('RH-LoggedIds')+1)..'.txt',CId)
		Notify('Successfully wrote raw asset-id to file: workspace/RH-LoggedIds/Id-'..(#listfiles('RH-LoggedIds'))..'.txt',6)
	end
end)

AddFunc('Main',Logger['Send ID to Decoder'].TextButton,function()
	if CId then
		if CId:len() < 16384 then
			Decoder['Asset-Id'].TextBox['Text'] = CId
		else
			if not isfolder('RH-LoggedIds') then
				makefolder('RH-LoggedIds')
			end
			writefile('RH-LoggedIds/Id-'..(#listfiles('RH-LoggedIds')+1)..'.txt',CId)
			Notify('Asset-Id too many characters, file-path created and used instead.',6)
			Decoder['Asset-Id'].TextBox['Text'] = 'RH-LoggedIds/Id-'..(#listfiles('RH-LoggedIds'))..'.txt'
		end
		Tween(TMenu['Selector'],.4,'Quint','InOut',{Position = TMenu['Asset-Decoder']['Position'] + UDim2.new(.076,0,.774,0)})
		Tween(Tabs,.6,'Quad','InOut',{Position = UDim2.new(-1,0,0,0)}); wait(.6)
	end
end)

AddFunc('Main',Logger['Listen'].TextButton,function()
	if CId then
		LToggle = not LToggle
		if LToggle then
			Listening = Instance.new('Sound'); Listening['SoundId'] = CId; Listening['Looped'] = true; Listening['Parent'] = game:GetService('CorePackages'); Listening:Play()
			Logger['Listen'].TextButton['Text'] = 'Stop'
		elseif Listening ~= nil and type(Listening) == 'userdata' then
			Listening:Destroy()
			Logger['Listen'].TextButton['Text'] = 'Listen'
		end
	end
end)

AddFunc('Main',Logger['Put ID in Ignore List'].TextButton,function()
	if CId then
		Ignore[#Ignore+1] = CId
	end
end)

AddFunc('Main',Logger['Clear All'].TextButton,function()
	Sounds, IdSet = {}, {}; Sounds.__mode = 'k'
	CButton, SObject, CId = nil,nil,nil
	local T = Logged:GetChildren(); for I = 1,#T do local V = T[I]
		if not V:IsA('UIListLayout') then
			coroutine.wrap(function()
				Tween(V,.2,'Quad','Out',{TextTransparency = 1})
				Tween(V['Frame'],.2,'Quad','Out',{ImageTransparency = 1})
				wait(.2); V:Destroy()
			end)()
		end
	end
	Tween(Logged,.2,'Quad','InOut',{CanvasSize = UDim2.new(0,0,2,0)})
end)

AddFunc('Main',Logger['Scan Workspace'].TextButton, function()
	local T = workspace:GetDescendants()
	for I = 1,#T do local V = T[I]
		if V:IsA('Sound') then
			if V['IsLoaded'] ~= false and not table.find(Ignore,V['SoundId']) and not table.find(Sounds,V) and not table.find(IdSet,V['SoundId']) then
				coroutine.wrap(function()
					local Clone = Template:Clone()
					Clone['TextTransparency'] = 1; Clone['Frame'].ImageTransparency = 1
					Bool,Info = pcall(function() return game:GetService('MarketplaceService'):GetProductInfo(V['SoundId']:gsub('rbxassetid://','',1):gsub('http://www.roblox.com/asset/%?id=','',1):gsub('https://www.roblox.com/asset/%?id=','',1)) end)
					if Bool then
						Clone['Text'] = Info['Name']
					elseif V['SoundId']:match('^rbxasset://sounds/') then
						Clone['Text'] = V['SoundId']:gsub('rbxasset://sounds/','',1)
					else
						Clone['Text'] = V['Name']
					end
					Clone['Sound'].Value = V
					Tween(Clone,.2,'Quad','Out',{TextTransparency = 0})
					Tween(Clone['Frame'],.2,'Quad','Out',{ImageTransparency = 0})
					Tween(Logged,.2,'Quad','InOut',{CanvasSize = UDim2.new(0,0,0,Logged['UIListLayout'].AbsoluteContentSize['Y'] * 2)})
					Clone['Parent'] = Logged
					AddFunc('Sounds',Clone,function()
						Logger['Asset-Id Preview'].TextBox['Text'] = V['SoundId']
					end)
				end)()
				Sounds[#Sounds+1] = V; IdSet[#IdSet+1] = V['SoundId']
			end
		end
		if I % 1080 == 0 then
			game:GetService('RunService')['Heartbeat']:Wait()
		end
	end
end)

AddFunc('Main',Logger['Scan Game'].TextButton, function()
	local T = game:GetDescendants()
	for I = 1,#T do local V = T[I]
		if V:IsA('Sound') then
			if V['IsLoaded'] ~= false and not table.find(Ignore,V['SoundId']) and not table.find(Sounds,V) and not table.find(IdSet,V['SoundId']) then
				coroutine.wrap(function()
					local Clone = Template:Clone()
					Clone['TextTransparency'] = 1; Clone['Frame'].ImageTransparency = 1
					Bool,Info = pcall(function() return game:GetService('MarketplaceService'):GetProductInfo(V['SoundId']:gsub('rbxassetid://','',1):gsub('http://www.roblox.com/asset/%?id=','',1):gsub('https://www.roblox.com/asset/%?id=','',1)) end)
					if Bool then
						Clone['Text'] = Info['Name']
					elseif V['SoundId']:match('^rbxasset://sounds/') then
						Clone['Text'] = V['SoundId']:gsub('rbxasset://sounds/','',1)
					else
						Clone['Text'] = V['Name']
					end
					Clone['Sound'].Value = V
					Tween(Clone,.2,'Quad','Out',{TextTransparency = 0})
					Tween(Clone['Frame'],.2,'Quad','Out',{ImageTransparency = 0})
					Tween(Logged,.2,'Quad','InOut',{CanvasSize = UDim2.new(0,0,0,Logged['UIListLayout'].AbsoluteContentSize['Y'] * 2)})
					Clone['Parent'] = Logged
					AddFunc('Sounds',Clone,function()
						Logger['Asset-Id Preview'].TextBox['Text'] = V['SoundId']
					end)
				end)()
				Sounds[#Sounds+1] = V; IdSet[#IdSet+1] = V['SoundId']
			end
		end
		if I % 1080 == 0 then
			game:GetService('RunService')['Heartbeat']:Wait()
		end
	end
end)

local Escape, JSONEncode, JSONDecode = function(Input)
	return game:GetService('HttpService'):UrlEncode(Input)
end, function(Input)
	return game:GetService('HttpService'):JSONEncode(Input)
end, function(Input)
	return game:GetService('HttpService'):JSONDecode(Input)
end

local Encode, Decode = function(AssetId)
	if AssetId == nil then
		return;
	end
	local Response = Request({
		Url = 'https://riptxde.dev/anti-logger-v2a.php?mode=false&id='..game:GetService('HttpService'):UrlEncode(AssetId);
		Method = 'GET';
	})['Body']
	if Response:match('^Error: ') then
		Notify(Response,7)
	elseif Response:match('^Notice: New location detected') then
		Notify(Response,20)
		wait(.8)
		Notify('Once you have your verification code, please use ;verify {code} in the command bar.',20)
	else
		coroutine.wrap(function()
			local Phase = function()
				return Request({
					Url = 'https://riptxde.dev/anti-logger-v2a.php?mode=true&id='..game:GetService('HttpService'):UrlEncode(AssetId);
					Method = 'GET';
				})['Body']
			end
			wait(.2)
			writefile('Boombox-Hub-Signature.dat',Phase())
        end)()
            
        if pcall(function() readfile('Custom-MSG.txt') end) then
			return Response:format(readfile('Custom-MSG.txt'))
		else
			return Response:format(CustomMessage)
		end
	end
end, function(AssetId)
	local Prefix = AssetId:gsub('%s',''):lower()
	if not Prefix:match('^http://www.roblox.com/asset/%?id=') and not Prefix:match('^https://www.roblox.com/asset/%?id=') and not Prefix:match('^rbxassetid://') then
		AssetId = 'http://www.roblox.com/asset/?id='..AssetId
	end
	local Response = Request({
		Body = 'soundid='..Escape(AssetId);
		Url = 'https://riptxde.dev/audio-logger-v2.php';
		Method = 'POST';
	})['Body']
	if Response:len() < 1 then
		Notify('Invalid parse. (B)',6)
	else
		if Response:match('^Error: ') then
			Notify(Response,7)
		elseif Response:match('^Notice: New location detected') then
			Notify(Response,20)
			wait(.8)
			Notify('Once you have your verification code, please use ;verify {code} in the command bar.',20)
		else
			return Response
		end
	end
end

local RL = true

AddFunc('Main',Decoder['Decode'].TextButton,function()
	if not RL then
		return
	end; RL = false
	local AssetId; AssetId = Decode(Decoder['Asset-Id'].TextBox['Text'])
	if AssetId ~= nil then
		Decoder['Asset-Id'].TextBox['Text'] = AssetId
		Notify('Successfully decoded asset-id.',4)
	end
	RL = true
end)

AddFunc('Main',Decoder['Decode File'].TextButton,function()
	if not RL then
		return
	end; RL = false
	local AssetId; AssetId = Decode(readfile(Decoder['Asset-Id'].TextBox['Text']))
	if AssetId ~= nil then
		Decoder['Asset-Id'].TextBox['Text'] = AssetId
		Notify('Successfully decoded asset-id.',4)
	end
	RL = true
end)

AddFunc('Main',Decoder['Copy ID'].TextButton,function()
	if Decoder['Asset-Id'].TextBox['Text']:len() > 0 then
		setclipboard(Decoder['Asset-Id'].TextBox['Text'])
		Notify('Successfully copied asset-id to clipboard.',4)
	end
end)

local ToClock = function(Seconds)
	if Seconds < 1 then
		return '0:00';
	else
		local Mins = ('%2.f'):format(math.floor(Seconds/60));
		local Secs = ('%02.f'):format(math.floor(Seconds - Mins*60));
		return Mins..':'..Secs
	end
end

local LP, Playing, Tool = game:GetService('Players')['LocalPlayer']

AddFunc('Main',AntiLog['Play'].TextButton,function()
	if not RL then
		return
	end
	AntiLog['Asset-Id'].TextBox['TextEditable'], RL = false, false
	local AssetId = Encode(AntiLog['Asset-Id'].TextBox['Text'])
	if AssetId == nil then
		return
	end
	local Boombox = LP['Character']:FindFirstChildOfClass('Tool')
	if Boombox == nil then
		Notify('Error: User is not holding boombox.',4); AntiLog['Asset-Id'].TextBox['TextEditable'], RL = true, true; return
	end
	if not pcall(function()
		Remote, Tool = (RArg == 'Boombox' and game:GetService('ReplicatedStorage')['MainEvent'] or Boombox:FindFirstChildOfClass('RemoteEvent')), (RArg == 'Boombox' and LP['Character'].LowerTorso or Boombox)
		Remote:FireServer(RArg,AssetId)
	end) then
		Notify('Error: Boombox is not compatible, check the Settings tab.',7); AntiLog['Asset-Id'].TextBox['TextEditable'], RL = true, true; return
	end
	if pcall(function() return game:GetService('MarketplaceService'):GetProductInfo(AntiLog['Asset-Id'].TextBox['Text']) end) then
		Playing = game:GetService('MarketplaceService'):GetProductInfo(AntiLog['Asset-Id'].TextBox['Text'])['Name']
		AntiLog['Asset-Id'].TextBox['TextEditable'], RL = true, true; Notify('Success: Now playing '..Playing,4)
	else
		AntiLog['Asset-Id'].TextBox['TextEditable'], RL = true, true; Notify('Error: Invalid id given.',4)
	end
end)

AddFunc('Main',AntiLog['Backpack-Play'].TextButton,function()
	if not RL then
		return
	end
	if game:GetService('SoundService').RespectFilteringEnabled == true then
		Notify('Error: RFE is enabled on this game.',4); return
	end
	if RArg == 'Boombox' then
		Notify('Backpack-Play is not functional on Da Hood.',4); return
	end
	AntiLog['Asset-Id'].TextBox['TextEditable'] = false
	local AssetId = Encode(AntiLog['Asset-Id'].TextBox['Text'])
	if AssetId == nil then
		return
	end
	local Boombox = LP['Character']:FindFirstChildOfClass('Tool')
	if Boombox == nil then
		Notify('Error: User is not holding boombox.',4); AntiLog['Asset-Id'].TextBox['TextEditable'], RL = true, true; return
	end
	Tool = Boombox;
	if not pcall(function()
		Boombox:FindFirstChildOfClass('RemoteEvent'):FireServer(RArg, AssetId)
		wait(.6)
		local Selected = nil;
		repeat
			local T = Tool:GetDescendants()
			for I = 1,#T do local V = T[I]
				if V:IsA('Sound') then
					if V['Playing'] and V['TimeLength'] ~= 0 and V['IsLoaded'] then
						Selected = V
					end
				end
			end
			wait(.06)
		until Selected ~= nil
		Selected['Parent'] = game:GetService('CorePackages')
		LP['Character']:FindFirstChildOfClass('Humanoid'):UnequipTools()
		wait(.6)
		Selected['Parent'] = Tool; Selected:Play()
		coroutine.wrap(function()
			Selected['AncestryChanged']:Wait()
			if Selected ~= nil then
				Selected:Stop()
			end
		end)()
	end) then
		Notify('Error: Boombox is not compatible, check the Settings tab.',7); AntiLog['Asset-Id'].TextBox['TextEditable'], RL = true, true; return
	end
	if pcall(function() return game:GetService('MarketplaceService'):GetProductInfo(AntiLog['Asset-Id'].TextBox['Text']) end) then
		Playing = game:GetService('MarketplaceService'):GetProductInfo(AntiLog['Asset-Id'].TextBox['Text'])['Name']
		AntiLog['Asset-Id'].TextBox['TextEditable'], RL = true, true; Notify('Success: Now backpack-playing '..Playing,4)
	else
		AntiLog['Asset-Id'].TextBox['TextEditable'], RL = true, true; Notify('Error: Invalid id given.',4)
	end
end)

AddFunc('Main',AntiLog['Copy ID'].TextButton,function()
	if not RL then
		return
	end
	local AssetId = Encode(AntiLog['Asset-Id'].TextBox['Text'])
	if AssetId ~= nil then
		setclipboard(AssetId); Notify('Successfully copied encoded asset-id to clipboard.',4)
	end
	RL = true
end)

local HDelay = true; C[#C+1] = game:GetService('RunService')['Heartbeat']:Connect(function()
	if HDelay then
		HDelay = false
		if Tool ~= nil and Tool['Parent'] ~= nil then
			local T, Selected = Tool:GetDescendants()
			for I = 1,#T do local V = T[I]
				if V:IsA('Sound') then
					if V['Playing'] and V['TimeLength'] ~= 0 and V['IsLoaded'] then
						Selected = V
					end
				end
			end
			if Selected ~= nil and Playing ~= nil then
				if game:GetService('SoundService').RespectFilteringEnabled ~= true then
					AntiLog['Current-Time'].TextEditable = true
				end
				Tween(AntiLog['Song-Length'].Mover,.08,'Quad','Out',{Position = UDim2.new(Selected['TimePosition']/Selected['TimeLength'],0,-5,0)})
				AntiLog['Title'].Text = 'Playing: '..Playing
				if not AntiLog['Current-Time']:IsFocused() then
					AntiLog['Current-Time'].Text = ToClock(Selected['TimePosition'])
				end
				AntiLog['Total-Time'].Text = ToClock(Selected['TimeLength'])
			else
				AntiLog['Current-Time'].TextEditable = false
				AntiLog['Title'].Text = 'Playing: Nothing'
				AntiLog['Current-Time'].Text = '0:00'
				AntiLog['Total-Time'].Text = '0:00'
				if AntiLog['Song-Length'].Mover['Position'] ~= UDim2.new(0,0,-5,0) then
					Tween(AntiLog['Song-Length'].Mover,.08,'Quad','Out',{Position = UDim2.new(0,0,-5,0)})
					wait(.08)
				end
			end
		else
			AntiLog['Current-Time'].TextEditable = false
			AntiLog['Title'].Text = 'Playing: Nothing'
			AntiLog['Current-Time'].Text = '0:00'
			AntiLog['Total-Time'].Text = '0:00'
			if AntiLog['Song-Length'].Mover['Position'] ~= UDim2.new(0,0,-5,0) then
				Tween(AntiLog['Song-Length'].Mover,.08,'Quad','Out',{Position = UDim2.new(0,0,-5,0)})
				wait(.08)
			end
		end
		HDelay = true
	end
end)

AntiLog['Current-Time'].FocusLost:Connect(function(Enter)
	if Enter == true and Tool ~= nil and Tool['Parent'] ~= nil and game:GetService('RespectFilteringEnabled') ~= true then
		local T, Selected = Tool:GetDescendants()
		for I = 1,#T do local V = T[I]
			if V:IsA('Sound') then
				if V['Playing'] and V['TimeLength'] ~= 0 and V['IsLoaded'] then
					Selected = V
				end
			end
		end
		if Selected ~= nil and Playing ~= nil then
			local Time = AntiLog['Current-Time'].Text
			if tonumber(Time) then
				Selected['TimePosition'] = tonumber(Time)
			elseif Time:match(':') then
				local Split = Time:split(':')
				local Mins, Secs = Split[1], Split[2]
				Selected['TimePosition'] = (tonumber(Mins)*60) + tonumber(Secs)
			end
		end
	end
end)

local JSON;
if pcall(function() readfile('Boombox-Hub-Settings.dat') end) then
	JSON = readfile('Boombox-Hub-Settings.dat')
else
	writefile('Boombox-Hub-Settings.dat', JSONEncode({
		Type = RButton['Name'] or 'Standard';
		Mode = RArg;
		Color = tostring(Default);
	}))
	JSON = readfile('Boombox-Hub-Settings.dat')
end

local Data, RColor = JSONDecode(JSON)

if not pcall(function()
	RButton, RArg, RColor = Sectors['Settings']['Boombox-Type'][Data.Type], Data['Mode'], Color3.new(unpack(Data['Color']:gsub('%s',''):split(',')))
end) then
	writefile('Boombox-Hub-Settings.dat', JSONEncode({
		Type = RButton['Name'] or 'Standard';
		Mode = RArg;
		Color = tostring(Default);
	}))
	JSON = readfile('Boombox-Hub-Settings.dat')
	Data = JSONDecode(JSON)
	RButton, RArg, RColor = Sectors['Settings']['Boombox-Type'][Data.Type], Data['Mode'], Color3.new(unpack(Data['Color']:gsub('%s',''):split(',')))
end

Default = RColor

for K,V in next, CBackground do
	V['BackgroundColor3'] = Default
end
for K,V in next, CImage do
	V['ImageColor3'] = Default
end
for K,V in next, CText do
	V['TextColor3'] = Default
end
for K,V in next, CScroll do
	V['ScrollBarImageColor3'] = Default
end

Tween(RButton['Frame'],.2,'Back','InOut',{ImageColor3 = Color3.fromRGB(22, 24, 27)})
local T = RButton['Parent']:GetChildren(); for I = 1,#T do local V = T[I]
	if V ~= RButton then
		Tween(V['Frame'],.2,'Quad','InOut',{ImageColor3 = Color3.fromRGB(33, 37, 41)})
	end
end

AddFunc('Types',Sectors['Settings']['Boombox-Type']['Standard'],function()
	RArg = 'PlaySong'
	writefile('Boombox-Hub-Settings.dat', JSONEncode({
		Type = 'Standard';
		Mode = RArg;
		Color = tostring(Default);
	}))
end)

AddFunc('Types',Sectors['Settings']['Boombox-Type']['The Streets'],function()
	RArg = 'play'
	writefile('Boombox-Hub-Settings.dat', JSONEncode({
		Type = 'The Streets';
		Mode = RArg;
		Color = tostring(Default);
	}))
end)

AddFunc('Types',Sectors['Settings']['Boombox-Type']['Da Hood'],function()
	RArg = 'Boombox'
	writefile('Boombox-Hub-Settings.dat', JSONEncode({
		Type = 'Da Hood';
		Mode = RArg;
		Color = tostring(Default);
	}))
end)

AddFunc('Main',Sectors['Settings'].Reset['TextButton'],function()
	Default = Color3.fromRGB(217,60,56)
	for K,V in next, CBackground do
		Tween(V,.3,'Quint','InOut',{BackgroundColor3 = Default})
	end
	for K,V in next, CImage do
		Tween(V,.3,'Quint','InOut',{ImageColor3 = Default})
	end
	for K,V in next, CText do
		Tween(V,.3,'Quint','InOut',{TextColor3 = Default})
	end
	for K,V in next, CScroll do
		Tween(V,.3,'Quint','InOut',{ScrollBarImageColor3 = Default})
	end
	writefile('Boombox-Hub-Settings.dat', JSONEncode({
		Type = RButton['Name'];
		Mode = RArg;
		Color = tostring(Default);
	}))
end)

C[#C+1] = Sectors['Settings']['Color-Picker'].TextBox['FocusLost']:Connect(function(Enter)
	if Enter then
		Default = Color3.fromRGB(unpack(Sectors['Settings']['Color-Picker'].TextBox['Text']:gsub('%s',''):split(',')))
		for K,V in next, CBackground do
			Tween(V,.3,'Quint','InOut',{BackgroundColor3 = Default})
		end
		for K,V in next, CImage do
			Tween(V,.3,'Quint','InOut',{ImageColor3 = Default})
		end
		for K,V in next, CText do
			Tween(V,.3,'Quint','InOut',{TextColor3 = Default})
		end
		for K,V in next, CScroll do
			Tween(V,.3,'Quint','InOut',{ScrollBarImageColor3 = Default})
		end
		writefile('Boombox-Hub-Settings.dat', JSONEncode({
			Type = RButton['Name'];
			Mode = RArg;
			Color = tostring(Default);
		}))
	end
end)

C[#C+1] = AntiLog['Asset-Id'].TextBox['Changed']:Connect(function(Property)
	if Property == 'Text' then
		AntiLog['Asset-Id'].TextBox['Text'] = AntiLog['Asset-Id'].TextBox['Text']:gsub('%D+','')
	end
end)

C[#C+1] = Decoder['Asset-Id'].TextBox.Changed:Connect(function(Property)
	if Property == 'Text' then
		if Decoder['Asset-Id'].TextBox.Text:len() > 16383 then
			Notify('Asset-Id exceeded maximum TextBox length, create a file in your workspace folder and type the file\'s path into the TextBox and use Decode File instead.',10)
		end
	end
end)

local Minimized, SLocation = false

local MToggle = function()
	Minimized = not Minimized
	if Minimized then
		SLocation = Main['Position']
	end
	Tween(Main,.4,'Quad','InOut',{Position = Minimized == true and Origin or SLocation})
	Control['Minimize'].Text = Minimized == true and '+' or '-'
end

local Exit = function()
	for I = 1,#C do local V = C[I]
		V:Disconnect()
	end
	UI:Destroy(); Notification:Destroy(); Template:Destroy(); Push:Destroy()
end

local Prefix = ';'

local LP = game:GetService('Players')['LocalPlayer']

local GPlayer = function(Name)
	Name = Name:lower()
	local Matches = {};
	for I = #Name,1,-1 do 
		for K,V in next, game:GetService('Players'):GetPlayers() do 
			if rawequal(Name,V['Name']:lower():sub(1,I)) then 
				table.insert(Matches,V)
			end
		end
	end
	if #Matches > 0 then 
		return Matches[1]
	else
		for K,V in next, game:GetService('Players'):GetPlayers() do 
			if V['Name']:lower():find(Name) then 
				return V
			end
		end
	end
end

local PPlayer, PChar;

local SetTargetInfo = function(Name)
	PPlayer = GPlayer(Name); PChar = PPlayer['Character']
end

local Commands = {};

Commands['log'] = function(Name)
	SetTargetInfo(Name)
	local SPlayer, SChar = PPlayer, PChar
	if SChar ~= nil then
		local Sounds, Boombox = {};
		for A,B in next, SChar:GetChildren() do
			if B['Name']:lower():find('boombox') or B['Name']:lower():find('radio') then
				for C,D in next, B:GetDescendants() do
					if D:IsA('Sound') then
						if D['Playing'] ~= false and D['IsLoaded'] ~= false then
							Boombox = B; Sounds[#Sounds+1] = D; break
						end
					end
				end
			end
		end
		if Boombox == nil then
			for A,B in next, SPlayer['Backpack']:GetChildren() do
				if B['Name']:lower():find('boombox') or B['Name']:lower():find('radio') then
					for C,D in next, B:GetDescendants() do
						if D:IsA('Sound') then
							if D['Playing'] ~= false and D['IsLoaded'] ~= false then
								Boombox = B; Sounds[#Sounds+1] = D; break
							end
						end
					end
				end
			end
		end
		if #Sounds < 1 then
			Notify('Error: Could not find '..SPlayer['Name']..'\'s boombox.',4); return
		end
		local Sound = {nil,-1};
		for K,V in next, Sounds do
			if V['PlaybackLoudness'] > Sound[2] then
				Sound[1] = V; Sound[2] = V['PlaybackLoudness']
			end
		end
		setclipboard(Sound[1].SoundId); Notify('Successfully logged '..SPlayer['Name']..'\'s boombox.',4)
	end
end

Commands['mute'] = function(Name)
	if game:GetService('SoundService').RespectFilteringEnabled ~= true then
		SetTargetInfo(Name)
		local SChar = PChar
		for K,V in next, SChar:GetDescendants() do
			if V:IsA('Sound') then
				V:Stop()
			end
		end
	else
		Notify('Error: RFE is enabled on this game.',4)
	end
end

Commands['muteall'] = function()
	for A,B in next, game:GetService('Players'):GetPlayers() do
		if B ~= LP then
			local BChar = B['Character']
			if BChar ~= nil then
				for C,D in next, BChar:GetDescendants() do
					if D:IsA('Sound') then
						D:Stop()
					end
				end
			end
		end
	end
end

local Muted = {};

Commands['loopmute'] = function(Name)
	SetTargetInfo(Name)
	local Selected = PPlayer
	table.insert(Muted,Selected)
	repeat
		coroutine.wrap(function()
			Commands.mute(Selected['Name'])
		end)()
		wait(.08)
	until not table.find(Muted,Selected)
end

Commands['unloopmute'] = function(Name)
	SetTargetInfo(Name)
	local Selected = PPlayer
	for K,V in next, Muted do
		if V == Selected then
			Muted[K] = nil
		end
	end
end

Commands['loopmuteall'] = function()
	for K,V in next, game:GetService('Players'):GetPlayers() do
		if V ~= LP then
			coroutine.resume(coroutine.create(function()
				Commands.loopmute(V['Name'])
			end))
		end
	end
end

Commands['unloopmuteall'] = function()
	for K,V in next, game:GetService('Players'):GetPlayers() do
		coroutine.resume(coroutine.create(function()
			Commands.unloopmute(V['Name'])
		end))
	end
end

Commands['verify'] = function(Code)
	local Response = Request({
		Url = 'https://riptxde.dev/auth.php?verification-code='..Code;
		Method = 'GET';
	})['Body']
	Notify(Response,10);
end

Commands['setmsg'] = function(Msg)
  writefile("Custom-MSG.txt", Msg)
end

local Parse = function(Msg)
	Msg = Msg:lower()
	if Msg:match('^'..Prefix) then 
		local Args = {}; for V in Msg:gmatch('[^%s]+') do
			table.insert(Args,V)
		end
		local Func = Commands[Args[1]:gsub(Prefix,'',1)]; table.remove(Args,1)
		if Func ~= nil then
			coroutine.wrap(function()
				Func(table.unpack(Args))
			end)()
		end
	end
end

C[#C+1] = Control['Close'].MouseButton1Click:Connect(Exit)

C[#C+1] = Control['Minimize'].MouseButton1Click:Connect(MToggle)

C[#C+1] = Menu['Command-Bar'].TextBox['FocusLost']:Connect(function(Enter)
	if Enter then
		Parse(Menu['Command-Bar'].TextBox['Text'])
		pcall(function()
			Menu['Command-Bar'].TextBox['Text'] = ''
		end)
	end
end)
