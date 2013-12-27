class 'Whitelist' -- Whitelist script by Twentysix

function Whitelist:__init()
	self.admins = {"ChangeMe", "AndMeTooIfYouWant"} -- Put admin's SteamID here (add/delete fields if needed)
	self.notification = false -- If true displays kicks in chat
	self.active = true
	self:LoadWhitelist()
	Events:Subscribe("PlayerAuthenticate", self, self.PlayerConnect)
	Events:Subscribe("PlayerChat", self, self.Commands)
end

function Whitelist:LoadWhitelist()
	self.list = {}
	local f = io.open( "whitelist.txt", "r" )

	for line in f:lines() do
		table.insert(self.list, line)
	end

	if #self.list == 0 then
		print("whitelist.txt is empty. Please add some Steam IDs")
		self.active = false -- Verification disabled
	end
	f.close()
end

function Whitelist:Verify(playerID)
	if self.active == false then return true end -- Only if whitelist.txt is empty
	local count = 1
	for i=#self.list,1,-1 do
		if self.list[count] == playerID then
			return true
		end
	count = count + 1
	end
end

function Whitelist:PlayerConnect(args)
	local id = args.player:GetSteamId().string
	local pname = args.player:GetName()
	if self:Verify(id) == true or self:isAdmin(id) == true then
		print(pname .. "(" .. id ..")" .. " joined the server")
	else
		print(pname .. "(" .. id ..")" .. " kicked from the server: not in whitelist")
		args.player:Kick("Your SteamID (" .. id .. ") is not whitelisted. Provide your SteamID to the administrator to obtain permission.")
		if self.notification == true then Chat:Broadcast("[Whitelist] " .. pname .. "(" .. id .. ") has been kicked from the server", Color(0,251,255)) end
	end
end

function Whitelist:Commands(args)
	local cmd = string.split(args.text, " ")
	local id = args.player:GetSteamId().string
	if self:isAdmin(id) == true then -- Player is admin
		if string.match(cmd[1], "/addsteamid") ~= nil and string.match(cmd[2], "STEAM_.*") ~= nil then
			local SteamID = cmd[2]
			local f = io.open( "whitelist.txt", "a" )
			f:write("\n".. SteamID)
			f:close()
			print(args.player:GetName() .. " whitelisted " .. SteamID)
			args.player:SendChatMessage("[Whitelist] " .. SteamID .. " is now whitelisted", Color(0,251,255))
			self:LoadWhitelist()
		elseif string.match(cmd[1], "/wnotifications") ~= nil then
			self.notification = not self.notification
			args.player:SendChatMessage("[Whitelist] Kick notifications set to: " .. tostring(self.notification), Color(0,251,255))
		elseif string.match(cmd[1], "/wreload") ~= nil then
			self:LoadWhitelist()
			args.player:SendChatMessage("[Whitelist] Whitelist reloaded", Color(0,251,255))
			print(args.player:GetName() .. " reloaded the whitelist")
		end
	end
end

function Whitelist:isAdmin(playerID)
	local count = 1
	for i=#self.admins,1,-1 do
		if self.admins[count] == playerID then
			return true
		end
	count = count + 1
	end
end

whitelist = Whitelist()