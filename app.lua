require "max7219"
require "network"
require "scrolling"
require "font"
require "font2"
require "texts"

setupMAX7219()
setupWIFI()
runServer()
showRaw("")
--showRaw("0026464040462600")
--showTime("0123")
--scrollText("ABC 12")
