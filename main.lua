
-- pin to use for detection
local pin_left =3 
local pin_right = 1
local debounceDelay = 200
local debounceAlarmID = 0
local canSend = false

function resetState()
    canSend = true
end

function sendKey(name)
    if canSend then
        canSend = false
        ip,nm,gw = wifi.sta.getip()
        gpio.write(4,gpio.LOW)
        print('send page '..name..'request')
        http.get('http://'..gw..':8080/VOLUME_'..name,nil, function() 
            canSend = true
            gpio.write(4,gpio.HIGH)
        end)
    else
        print('Outstanding Reuqest. Please wait')
    end
end

function goRightDown()
    gpio.trig(pin_right, 'none')
    tmr.alarm(debounceAlarmID, debounceDelay, tmr.ALARM_SINGLE, function()
        gpio.trig(pin_right, 'up', goRightUp)
    end)
    print('RIGHT went DOWN')
    sendKey('DOWN')
end

function goLeftDown()
    gpio.trig(pin_left, 'none')
    tmr.alarm(debounceAlarmID, debounceDelay, tmr.ALARM_SINGLE, function()
        gpio.trig(pin_left, 'up', goLeftUp)
    end)
    print('LEFT went DOWN')
    sendKey('UP')
end

function goRightUp()
    gpio.trig(pin_right, 'none')
    tmr.alarm(debounceAlarmID, debounceDelay, tmr.ALARM_SINGLE, function()
        gpio.trig(pin_right, 'down', goRightDown)
    end)
    print('RIGHT went UP')
end

function goLeftUp()
    gpio.trig(pin_left, 'none')
    tmr.alarm(debounceAlarmID, debounceDelay, tmr.ALARM_SINGLE, function()
        gpio.trig(pin_left, 'down', goLeftDown)
    end)
    print('LEFT went UP')
end


gpio.mode(pin_right, gpio.INT, gpio.PULLUP)
gpio.trig(pin_right, 'down', goRightUp)

gpio.mode(pin_left, gpio.INT, gpio.PULLUP)
gpio.trig(pin_left, 'down', goLeftUp)
