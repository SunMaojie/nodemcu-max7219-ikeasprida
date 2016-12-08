function setupWIFI()
	SSID = ""
	PW = ""
	IP = ""
	GW = ""
	NETMASK = ""
	wifi.setmode(wifi.STATION)
	wifi.sta.setip({ip=IP,netmask=NETMAS,gateway=GW})
	wifi.sta.config(SSID,PW)
end

function urldecode(s)
  s = s:gsub('+', ' ')
       :gsub('%%(%x%x)', function(h)
                           return string.char(tonumber(h, 16))
                         end)
  return s
end

function parseurl(s)
  -- s = s:match('%s+(.+)')
  local ans = {}
  for k,v in s:gmatch('([^&=?]-)=([^&=?]+)' ) do
    ans[ k ] = urldecode(v)
  end
  return ans
end

function runServer()
	srv=net.createServer(net.TCP)
	srv:listen(80,function(conn)
    	conn:on("receive", function(client,request)
        	local buf = "";
        	local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        	if(method == nil)then
            	_, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        	end
			local _GET = {}
			if (vars ~= nil) then
				_GET = parseurl(vars)
			end

        	buf = buf.."<h1> ESP8266 Web Server</h1>";

			if (_GET.request ~= nil and _GET.cmd ~= nil) then
				buf = buf.." cmd: ".._GET.cmd.." req: ".._GET.request
	        	if (_GET.cmd == "scroll") then
					scrollText(_GET.request)
				elseif (_GET.cmd == "time") then
					showTime(_GET.request)
				elseif (_GET.cmd == "raw") then
					showRaw(_GET.request)
				end
			end

        	client:send(buf);
        	client:close();
        	collectgarbage();
    	end)
	end)
end
