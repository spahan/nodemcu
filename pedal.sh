LUATOOL=/home/spahan/nodemcu/luatool/luatool/luatool.py
PORT=/dev/ttyUSB0
FILES="init.lua lib.lua wifi.lua main.lua"

for x in $FILES; do
	$LUATOOL -b 115200 --port $PORT --src $x --dest $x
done
