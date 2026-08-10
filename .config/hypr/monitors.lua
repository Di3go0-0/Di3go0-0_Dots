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
hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@100",
	position = "1440x0",
	scale = 1,
})

hl.monitor({
	output = "DP-2",
	mode = "1920x1080@60",
	position = "1760x1080",
	scale = 1.5,
})

-- Workspaces por defecto por monitor
-- Si el monitor existe, el WS arranca ahi. Si no, fallback al primer monitor disponible.
hl.workspace_rule({ workspace = "1", monitor = "eDP-2",    default = true })
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-1", default = true })
hl.workspace_rule({ workspace = "3", monitor = "DP-2",     default = true })
