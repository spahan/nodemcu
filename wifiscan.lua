LED = 4
MAXDUTY = 1023
MINDUTY = 0

EVENTTIMER = 0
EVENTTIME = 100
STARTUPTIMER = 1
STARTUPDELAY=5000

EMERG = 0
ALERT = 1
CRITICAL = 2
ERROR = 3
WARNING = 4
NOTICE = 5
INFO = 6
DEBUG = 7

state = {
    duty = MAXDUTY,
    running = true,
    loglevel = NOTICE,
    duty_up = 10,
    duty_down = 1
}

function proberecved(t)
    state.duty = state.duty - state.duty_down*(100+t.RSSI)
    if (state.duty < MINDUTY) then
        state.duty = MINDUTY
    end
    if (state.loglevel >= INFO) then
        print("received probe: "..t.MAC.." "..t.RSSI.."\t"..state.duty)
    end
end

function eventloop()
    if (state.loglevel >= DEBUG) then
        print("eventloop: "..state.duty)
    end
    if (state.running) then
        state.duty = state.duty + state.duty_up
        if (state.duty > MAXDUTY) then
            state.duty = MAXDUTY
        end
        pwm.setduty(LED,state.duty)
    else
        if (state.loglevel >= INFO) then
            print("Stopping scanner")
        end
        wifi.eventmon.unregister(wifi.eventmon.AP_PROBEREQRECVED)
        tmr.unregister(EVENTTIMER)
    end
end

function init()
    if (state.loglevel >= NOTICE) then
        print("Starting scanner")
    end
    pwm.setup(LED,50,state.duty)
    pwm.start(LED)
    wifi.eventmon.register(wifi.eventmon.AP_PROBEREQRECVED, proberecved)
    wifi.setmode(wifi.SOFTAP)
    tmr.alarm(EVENTTIMER,EVENTTIME,tmr.ALARM_AUTO,eventloop)
    if (state.loglevel >= INFO) then
        print("done initializing scanner")
    end
end


tmr.alarm(STARTUPTIMER,STARTUPDELAY,tmr.ALARM_SINGLE,init)
