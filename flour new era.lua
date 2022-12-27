world = "C2YYGM" --, "CORH5G", "CTE6UV",
doorid = "IMAEZA"
listworld = 6
delayplace = 90
delaybreak = 165
bg = 888 -- New v 15
dix = 50
diy = 19
worldsave = "BASEMAZA"
idsave = "IMAEZA"
left = 48 -- Left Plat
right = 48 -- Right Plat
buypack = "fishin_pack"
price = 10000
interval = 1000
dflour = 284
dssp = 108
inthp = 100
hitblock = 2
PackIdlist = {2912,2914,5522,5524,3044,3004,3002}


function powershelldisconnect(loglars,tagar,linkwb)
  local script = [[
    $webHookUrl = ']]..linkwb..[['
    [System.Collections.ArrayList]$embedArray = @()

    $Body = @{
      'content' = ''
    }
    $title       = 'Connection Logs'
    $description = 'Info : ]]..loglars..[[  ]].."\n"..[[Current Bot : ]]..getBot().name..[[ ]].."\n"..[[Current World : ]]..world..[[ ]].."\n"..[[ Status Bot : ]]..getBot().status..[[ (]]..getPing()..[[) ]].."\n"..[[ Postion : ]]..(getBot().x)..[[,]]..(getBot().y)..[[ ]].."\n"..[[ Captcha Status : ]]..getBot().captcha..[[ ]].."\n"..[[ World list : ]]..listworld..[[ ]].."\n"..[[ ]]..(os.date"Date= %d/%m/%Y")..[[ ]].."\n"..[[ ]]..(os.date"Hour= %H:%M:%S")..[['

    $color       = '16711680'
    }
    $embedObject = [PSCustomObject]@{

      title       = $title
      description = $description
      color       = $color
      thumbnail   = $thumbnailObject
      image       = $imageObject
      footer      = $footer
  
    }
    $embedArray.Add($embedObject) | Out-Null
    $payload = [PSCustomObject]@{

      'avatar_url' = 'https://media.discordapp.net/attachments/976510642892726292/1002186031774306324/Gaming-PFP-9.webp'
      'username' = 'Mr.Connection'
      'content' = ']]..tagar..[['
      embeds = $embedArray
  
    }
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    Invoke-RestMethod -Uri $webHookUrl -Body ($payload | ConvertTo-Json -Depth 4) -Method Post -ContentType 'application/json'
  ]]
    
  local pipe = io.popen("powershell -command -", "w")
  pipe:write(script)
  pipe:close()
end

function main()
    tresh1 = {882,2,3,48,5028,5032,5034,5036,5038,5040,5042,5044,7162,7164,9204}
    local function clear()
      for _,it in ipairs(tresh1) do
        if findItem(it) > 0 then 
          local tresh = findItem(it)
          sendPacket(2, "action|trash\n|itemID|".. it)
          sleep(2000)
          sendPacket(2, "action|dialog_return\ndialog_name|trash_item\nitemID|" .. it .. "|\ncount|" .. tresh) 
          sleep(2000)
          tresh = nil
        end
      end
    end

    local function join(name, doorid)
      sleep(3000)
      sendPacket(3,"action|join_request\nname|EXIT\ninvitedWorld|0")
      sleep(5000)
      sendPacket(3,"action|join_request\nname|"..name.."|"..doorid.."\ninvitedWorld|0")
      sleep(3000)
    end

    local function drops(id,a)
      sendPacket(2,"action|drop\n|itemID|"..id)
      sleep(2000)
      sendPacket(2,"action|dialog_return\ndialog_name|drop_item\nitemID|"..id.."|\ncount|"..a)
      sleep(2000)
    end

    local function rec()
      if getBot().status ~= "online" then
        sleep(2000)
        setBool("Auto Reconnect", false)
        powershelldisconnect("Bot Disconnect","","https://discord.com/api/webhooks/987806306402467850/ZcJuTZDCRTXfEaY6Tok-bW7MSLmkrqD5yrTpG4ajQWEDVtMkxEwKJAyNBcp3DhdqsScB")
        sleep(60000)
        connect()
        sleep(5000)
        while getBot().status ~= "online" do
          sleep(20000)
          connect()
          powershelldisconnect("Cant Reconnect","<@991882071809200188>","https://discord.com/api/webhooks/1025417635871076424/cAAjP4IgeDSuGKCEIDbj1gpcGJqIZP3cweVt14_2NKk1w-1XUGYsUXKMoO3hox-VDljA")
          if getBot().status:find("login") then
            sleep(2000)
            while getBot().status:find("login") do
              sleep(15000)
              connect()
              sleep(5000)
              powershelldisconnect("Bot Login Fail","","https://discord.com/api/webhooks/1025457752841125938/vtQ4GcHZmNT9HqoT_cCgxbKICXKG6AbEV9MeJUMJ2KTYzhYYc5p1B4qUTpNMGQd8eSrg")
            end
          end
        end        
        sleep(3000)
        powershelldisconnect("Bot Success Reconnected","","https://discord.com/api/webhooks/987806306402467850/ZcJuTZDCRTXfEaY6Tok-bW7MSLmkrqD5yrTpG4ajQWEDVtMkxEwKJAyNBcp3DhdqsScB")
        sleep(10000)
        join(world,doorid)
        sleep(10000)
        say("`2Reconnected")
        sleep(5000)
        findPath(math.floor(dix),math.floor(diy))
        sleep(2000)
      end
    end

    local function capta()
      if getBot().captcha == "Couldn't solve" then
        sleep(500)
        powershelldisconnect("Bot Trying Solve","","https://discord.com/api/webhooks/1030860476147581008/PjQ5FjA6tv5Wa4p29a-Pg1IyJKVbNsff1XkeOeHDCIq-ytoPJGKYNy-yBC0yDsTqqOVQ")
        sleep(500)
        disconnect()
        sleep(15000)
        connect()
        sleep(15000)        
        while getBot().captcha == "Couldn't solve" do
          powershelldisconnect("Cant Solve Please Remove Bot","<@991882071809200188>","https://discord.com/api/webhooks/1030860476147581008/PjQ5FjA6tv5Wa4p29a-Pg1IyJKVbNsff1XkeOeHDCIq-ytoPJGKYNy-yBC0yDsTqqOVQ")
          disconnect()
          sleep(15000)
          connect()
          sleep(15000)
        end
        powershelldisconnect("Bot Solved Captcha","","https://discord.com/api/webhooks/1030860476147581008/PjQ5FjA6tv5Wa4p29a-Pg1IyJKVbNsff1XkeOeHDCIq-ytoPJGKYNy-yBC0yDsTqqOVQ")
        if getTile(math.floor(getBot().x/32),math.floor(getBot().y/32)).fg == 6 then
          sleep(4000)
          join(world,doorid)
          sleep(4000)
          findPath(math.floor(dix),math.floor(diy))
          sleep(4000)
        end
      end
    end


    local function dropblock(dropss, ItemID)
      for _, tile in pairs(getTiles()) do
        if tile.fg == dropss then
          findPath(tile.x,tile.y) 
          sleep(2000)
          drops(ItemID,findItem(ItemID))
          sleep(2000)
          if findItem(ItemID) == 0 then goto END end
            punch(0,0)
            sleep(300)
            punch(0,0)
            sleep(300)
            punch(0,0)
            sleep(300)
            punch(0,0)
            sleep(300)
            punch(0,0)
            sleep(300)
            punch(0,0)
            sleep(300)
        end
      end
    ::END::
    end

    function gs(id)
      count = 0
      for _, object in pairs(getObjects()) do
        if object.id == id then
          count = count + object.count
        end
      end
      return count
    end

    local function takeblock(takes, ItemID)
      for _, tile in pairs(getTiles()) do
        if tile.bg == takes then
          findPath(tile.x,tile.y)
          sleep(2000)
          collectSet(true,2)
          sleep(2000)
          collectSet(false,2)
          if findItem(ItemID) > 199 then goto END end
        end
      end
    ::END::
    end

    local function DropPacks(dropsss)
      for _, tile in pairs(getTiles()) do
        if tile.fg == dropsss then
          findPath(tile.x,tile.y)
          sleep(5000)
          for _,i in ipairs(PackIdlist) do
            while findItem(i) > 0 do 
              local Drep = findItem(i)
              sendPacket(2, "action|drop\nitemID|" .. i)
              sleep(1000)
              sendPacket(2,"action|dialog_return\ndialog_name|drop_item\nitemID|" .. i .. "|\ncount|" .. Drep)
              sleep(2000)
              move(1,0)
              sleep(400)
              Drep = nil
            end
          end
        end
      end
    end

    local function move1()
      while true do
        sleep(500)
        takeblock(dflour, 4562)
        sleep(500)
        join(worldsave,idsave)
        sleep(500)
    rec()
        dropblock(880, 4562)
        sleep(1000)
        powershelldisconnect("Flour : "..gs(4562).." Ssp : "..gs(5706),"","https://discord.com/api/webhooks/995156393575333999/uAzq-hH_jIDYA2-91dHSRwkWXuftVk3-n49iPJdd67Ps3U4NXEGp0Y05oXTVl_D3C9U5")
        join(world,doorid)
        sleep(300)
        count = 0
        for _, object in pairs(getObjects()) do
          if object.id == 4562 then
            count = count + object.count
          end
        end
        if count < 199 then
          break
        end
      end
    end

    local function move2()
      collectSet(false, 2)
      while true do
        sleep(500)
        join(worldsave,idsave)
        sleep(500)
    rec()
        DropPacks(4584)
        sleep(500)
        join(world,doorid)
        sleep(500)
        if findItem(3044) == 0 then
          break
        end
      end
      collectSet(true, 2)
    end

    local function moveflour()
    count = 0
      for _, object in pairs(getObjects()) do
        if object.id == 4562 then
          count = count + object.count
        end
        if count > 199 then
          move1()
        end
      end
      if findItem(4562) == 200 then
        move1()
      end
    return count
    end

    local function movessp()
      count = 0
      for _, object in pairs(getObjects()) do
        if object.id == 5706 then
          count = count + object.count
        end
        if count > 199 then
          move2()
        end
      end
      return count
    end

    local function pnb2()
      while findItem(880) > 0 do
        ::PLACE::
        place(880,-1,0)
        sleep(delayplace)
        place(880,1,0)
        sleep(delayplace)
        capta()
        while getTile(math.floor(getposx() /32) -1,math.floor(getposy() /32)).fg ~= 0 and getTile(math.floor(getposx() /32) +1,math.floor(getposy() /32)).fg ~= 0 do
          for i = 0, hitblock, 1 do
            punch(-1,0)
            sleep(delaybreak)
            punch(1,0)
            sleep(delaybreak)
            capta()
            rec()
            while getTile(math.floor(getposx() /32) -1,math.floor(getposy() /32)).fg == 0 and getTile(math.floor(getposx() /32) +1,math.floor(getposy() /32)).fg == 0 do
              goto PLACE end
          end
        end
        rec()
      end
    end

    join(world,doorid)
    sleep(7000)
    say("Who Buy?")
    sleep(5000)
    while true do
      capta()
      if getBot().status:find("suspend") then
        sleep(1000)
        powershelldisconnect("Bot Got Suspended","<@991882071809200188>","https://discord.com/api/webhooks/1025459447730032771/pURjBQkOY5dlw8UykoMZm6VKsfpFpNmBVL18oowChzZcSG7s0XZVfLNquisAXe7mql4-")
        sleep(1000)
      end
      while findItem(112) >= price do
        sleep(5000)
        sendPacket(2, "action|buy\nitem|"..buypack)
        sleep(5000)
      end
      if findItem(112) >= 100 and getBot().slots == 16 then
        sleep(5000)
        sendPacket(2, "action|buy\nitem|upgrade_backpack")
        sleep(5000)
      end
      if findItem(3044) > 0 then
        sleep(500)
        move2()
      end
      if findItem(12498) >= 3 then
         join(worldsave, idsave)
         for _, tile in pairs(getTiles()) do
            if tile.bg == 118 then
              sleep(1200)
               findPath(tile.x,tile.y)
               collectSet(false,2)
               sleep(1200)
               drops(12498,findItem(12498))
               sleep(1000)
               join(world,doorid)
               sleep(400)
               collectSet(true,2)
            end
         end
      end
      moveflour()
      movessp(s)
      rec()
      if findItem(880) > 100 and findItem(881) > 100 then
         for _, tile in pairs(getTiles()) do
            if tile.fg == 4582 then
               findPath(tile.x,tile.y+1)
               sleep(interval)
               place(880,0,-1)
      rec()     
               sleep(500)
               sendPacket(2, "action|dialog_return\ndialog_name|grinder\ntilex|"..(getposx()/32).."|\ntiley|"..(getposy()/32 - 1).."|\nitemID|880|\ncount|2")
               sleep(1000)
               for _, tile in pairs(getTiles()) do
                  if tile.bg == dflour then            
                     findPath(tile.x -1,tile.y)
                     collectSet(false,2)
                     if findItem(4562) > 1 then
                        sleep(1500)
                        drops(4562,findItem(4562))
      rec()                  
                        sleep(1000)
                     end
                     if findItem(5706) > 9 then
                        for _, tile in pairs(getTiles()) do
                           if tile.bg == dssp then
                              findPath(tile.x,tile.y)
                              collectSet(false,2)
                              sleep(1500)
                              drops(5706,findItem(5706))
      rec()                        
                              sleep(1000)
                           end
                        end
                     end
                  end
               end
            end
         end
      end
      rec()
      findPath(math.floor(dix),math.floor(diy))
      clear()
      sleep(interval)
      collectSet(true,2)
      pnb2()
      move(-1,0)
      sleep(200)
      for il = (left),-1,-1 do
         move(-1,0)
         sleep(inthp)
         punch(0,0)
         sleep(inthp)
      rec()   
      end
      for ir = (right),1,-1 do
         move(1,0)
         sleep(inthp)
         place(881,0,0)
         sleep(inthp)
      rec()
      end
      collectSet(false,2)
      if findItem(880) > 100 and findItem(881) > 100 then
         for _, tile in pairs(getTiles()) do
            if tile.fg == 4582 then
               findPath(tile.x,tile.y+1)
               sleep(interval)
               place(880,0,-1)
      rec()    
               sleep(500)
               sendPacket(2, "action|dialog_return\ndialog_name|grinder\ntilex|"..(getposx()/32).."|\ntiley|"..(getposy()/32 - 1).."|\nitemID|880|\ncount|2")
               sleep(1000)
               for _, tile in pairs(getTiles()) do
                  if tile.bg == dflour then            
                     findPath(tile.x -1,tile.y)
                     collectSet(false,2)
                     if findItem(4562) > 1 then
                        sleep(1500)
                        drops(4562,findItem(4562))
      rec()                     
                        sleep(1000)
                     end
                     if findItem(5706) > 9 then
                        for _, tile in pairs(getTiles()) do
                           if tile.bg == dssp then
                              findPath(tile.x,tile.y)
                              collectSet(false,2)
                              sleep(1500)
                              drops(5706,findItem(5706))
      rec()                      
                              sleep(1000)
                           end
                        end
                     end
                  end
               end
            end
         end
      end
      rec()
      findPath(math.floor(dix),math.floor(diy))
      sleep(interval)
      collectSet(true,2)
      pnb2()
      move(1,0)
      sleep(200)
      for ir = (right),1,-1 do
         move(1,0)
         sleep(inthp)
         punch(0,0)
         sleep(inthp)
      rec()     
      end
      for il = (left),1,-1 do
         move(-1,0)
         sleep(inthp)
         place(881,0,0)
         sleep(inthp)
      rec()
      end
      collectSet(false,2)
    end
end

main()