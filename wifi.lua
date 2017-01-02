-- Print AP list that is easier to read
function listap(t) -- (SSID : Authmode, RSSI, BSSID, Channel)
    print("\n\t\t\tSSID\t\t\t\tBSSID\t\t  RSSI\t\t\tAUTHMODE\t\tCHANNEL")
    for bssid,v in pairs(t) do
        local ssid, rssi, authmode, channel = string.match(v, "([^,]+),([^,]+),([^,]+),([^,]*)")
        print(string.format("%32s",ssid).."\t"..bssid.."\t  "..rssi.."\t\t"..authmode.."\t\t\t"..channel)
    end
end

led = 4
state = true

--function setState()
--    if (state) then
--        gpio.write(led, gpio.LOW)
--    else
--        gpio.write(led,gpio.HIGH)
--    end
--   state = state ~= true
--end

-- Init LED
--gpio.mode(led, gpio.OUTPUT)
--setState()

-- scan periodicaly
--tmr.alarm(0,5000,tmr.ALARM_AUTO,function()
--    wifi.sta.getap(1,listap)
--    setState()
--end)

--register eventmonitor
wifi.eventmon.register(wifi.eventmon.AP_PROBEREQRECVED, function(t)
    print("eventmon"..t.MAC.."\t"..t.RSSI)
end)
