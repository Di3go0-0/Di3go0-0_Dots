-- █▀▄▀█ █▀█ █▄░█ █ ▀█▀ █▀█ █▀█ █▀
-- █░▀░█ █▄█ █░▀█ █ ░█░ █▄█ █▀▄ ▄█

-- Monitor Laptop (Izquierda)
hl.monitor({
	output = "eDP-2",
	mode = "1920x1080@144",
	position = "0x0",
	scale = 1.333334,
})

-- Monitor AOC (Derecha) - 100Hz
local hdmi_config = {
	output = "HDMI-A-1",
	mode = "1920x1080@100",
	position = "1440x0",
	scale = 1,
}

hl.monitor(hdmi_config)

-- Re-aplicar config al reconectar monitor (fix mouse limitado)
hl.on("monitor.added", function(name)
	if name == "HDMI-A-1" then
		hl.monitor(hdmi_config)
	end
end)
