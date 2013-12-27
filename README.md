This whitelist is based on SteamIDs. Not allowed players will be kicked when they reach the loading screen.

If the whitelist.txt is empty everyone can join but their SteamIDs will still show up in the server's console.

**Commands:**  
```
/addsteamid  
/wnotifications  
/wreload  
```

**Usage:**  
- You can type allowed SteamIDs in whitelist.txt, one each line, like this:

```
STEAM_0:1:12345678  
STEAM_0:1:87654321  
STEAM_0:1:12344321  
```

Or

- You can add allowed SteamIDs in game, like this:  

`/addsteamid STEAM_0:1:12345678`

**ONLY ADMINS can do that.** You need to add your/their SteamID in the whitelist.lua script, line 4:

`self.admins = {"ChangeMe", "AndMeTooIfYouWant"}`  
to  
`self.admins = {"STEAM_0:1:12345678", "STEAM_0:1:87654321"}` 

You can add/remove as much fields as you want, example:  

`self.admins = {"STEAM_0:1:12345678", "STEAM_0:1:87654321", "STEAM_0:1:12344321"}`  
or  
`self.admins = {"STEAM_0:1:12345678"}`  

- Ingame kick notifications (chat) are switched off by default, you can enable/disable them with the admin command  
`/wnotifications`  

They won't be enabled/disabled permanently though. To do that you need to edit this line(6) in the whitelist.lua:

`self.notification = false`  
to  
`self.notification = true`  
Of course false means they're disabled, true enabled.

- If you modify the whitelist.txt you will need to reload the script or use the following command:  
`/wreload`
