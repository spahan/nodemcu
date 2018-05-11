local status=nil
local err = 0

gpio.mode(4,gpio.OUTPUT)
gpio.write(4,gpio.LOW)
print('Loading...')
lib = loadfile('lib.lua')
wlan = loadfile('wifi.lua')
main = loadfile('main.lua')

if lib then status,err = pcall(lib) end
if status == false then print(err) end

if wlan then status,err = pcall(wlan) end
if status == false then print(err) end

if main then status,err = pcall(main) end
if status == false then print(err) end

gpio.write(4,gpio.HIGH)
print('done\n')
