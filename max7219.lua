function sendByte(reg, data)
  spi.send(1, reg * 256 + data)
  tmr.delay(50)
end

function setupMAX7219()
	MAX7219_REG_NOOP        = 0x00
	MAX7219_REG_DECODEMODE  = 0x09
	MAX7219_REG_INTENSITY   = 0x0A
	MAX7219_REG_SCANLIMIT   = 0x0B
	MAX7219_REG_SHUTDOWN    = 0x0C
	MAX7219_REG_DISPLAYTEST = 0x0F
    
	spi.setup(1, spi.MASTER, spi.CPOL_LOW, spi.CPHA_LOW, 16, 8)

    sendByte (MAX7219_REG_SHUTDOWN, 1)
    sendByte (MAX7219_REG_SCANLIMIT, 7)
    sendByte (MAX7219_REG_DECODEMODE, 0x00)
    sendByte (MAX7219_REG_DISPLAYTEST, 0)
    sendByte (MAX7219_REG_INTENSITY, 9)
    sendByte (MAX7219_REG_SHUTDOWN, 1)
    
    tmr.stop(0)
end
