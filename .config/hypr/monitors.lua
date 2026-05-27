-- █▀▄▀█ █▀█ █▄░█ █ ▀█▀ █▀█ █▀█ █▀
-- █░▀░█ █▄█ █░▀█ █ ░█░ █▄█ █▀▄ ▄█

-- Monitor Laptop (Izquierda)
hl.monitor({
	output = "eDP-1",
	-- output = "eDP-1",
	mode = "1920x1080@60",
	position = "0x0",
	-- scale = 1,
	scale = 1.25,
	-- scale = 1.3333334,
})

-- Monitor AOC (Derecha) - 100Hz
-- local hdmi_config = {
-- 	-- output = "HDMI-A-1",
-- 	output = "HDMI-A-1",
-- 	mode = "1920x1080@100",
-- 	position = "1536x0",
-- 	scale = 1,
-- }
local hdmi_config = {
	-- output = "HDMI-A-1",
	output = "HDMI-A-1",
	mode = "1920x1080@100",
	position = "1536x0",
	scale = 1,
}

hl.monitor(hdmi_config)

-- Re-aplicar config al reconectar monitor (fix mouse limitado)
hl.on("monitor.added", function(name)
	if name == "HDMI-A-1" then
		hl.monitor(hdmi_config)
	end
end)

-- Monitor iPad (Abajo del HDMI)
local ipad_config = {
	mode = "1920x1080@100",
	position = "1536x1080",
	scale = 1.33,
}

hl.on("monitor.added", function(name)
	if name:match("^HEADLESS") then
		ipad_config.output = name
		hl.monitor(ipad_config)
	end
end)
