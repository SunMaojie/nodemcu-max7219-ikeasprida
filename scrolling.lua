function text2byte(str)
	arr = {}
	local k = 1
	for i = 1, #str do
		local c = str:sub(i, i)
		local b = string.byte(c)
		b = b - 32 + 1
		if (b <= 60) then
			for j = 1, 8 do 
				arr[k] = cp437_font[b][j]
				k = k + 1
			end
		end
	end
	return arr
end

MAX = 2
function _scrollText(index,  arr, cur)
	if (index + 7 >= #arr) then
		index = 1
		cur = cur + 1
		if (cur == MAX) then return end
	end
	for i=index + 7, index, -1 do
		sendByte(8 - (i - index), arr[i])
	end
	tmr.alarm(1, 100, tmr.ALARM_SINGLE, function()
		index = index + 1
		_scrollText(index,  arr, cur)
	end)
end

function scrollText(data)
	data = " "..data.." "
    arr = text2byte(data)
	_scrollText(1, arr, 1)
end
