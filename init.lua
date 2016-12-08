local IDLE_AT_STARTUP_MS = 10000;
tmr.alarm(1,IDLE_AT_STARTUP_MS,tmr.ALARM_SINGLE,function()
    dofile("app.lua")
end)
