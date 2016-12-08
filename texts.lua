function display(data)
	for i = 8, 1, -1 do
		sendByte(8 - i + 1, data[i])
	end
end

function _showTime(h1, h2, m1, m2)
	screen = {0, 0, 0, 0, 0, 0, 0, 0}

	for i = 1, 3 do
		x = font3x3[m1 + 1][i]
		x = bit.lshift(x, 4)
		x = bit.bor(x, font3x3[h1 + 1][i])
		screen[i] = x

		x = font3x3[m2 + 1][i]
		x = bit.lshift(x, 4)
		x = bit.bor(x, font3x3[h2 + 1][i])
		screen[i + 4] = x
	end

	display(screen)
end

function parseTime(str)
	if (str == nil or #str ~= 4 or tonumber(str) == nil) then
		return 10, 10, 10, 10 end
	return tonumber(str:sub(1, 1)), tonumber(str:sub(2, 2)), tonumber(str:sub(3, 3)), tonumber(str:sub(4,4))
end

function showTime(str)
	h1, h2, m1, m2 = parseTime(str)
	_showTime(h1, h2, m1, m2)
end

function parseRaw(data)
	res = {0, 0, 0, 0, 0, 0, 0, 0}
	if (data ~= nil and #data == 16) then
		for i = 1, 8 do
			res[i] = tonumber(data:sub(i * 2 - 1, i * 2), 16)
		end
	end
	return res
end

function showRaw(data)
	arr = parseRaw(data)
	display(arr)
end
