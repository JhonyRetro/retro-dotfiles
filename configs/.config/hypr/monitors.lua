hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1080@144",
    position = "0x1440",
    scale    = 1,
})
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})
hl.monitor({
    output   = "desc:Philips Consumer Electronics Company 32B1N3800 AU02612012082",
    mode     = "3840x2160@60",
    position = "0x0",
    scale    = 1.5,
})

-- Workspace rules 
hl.workspace_rule({
	workspace = "1",
	monitor = "eDP-1",
	default = true
})

hl.workspace_rule({
	workspace = "2",
	monitor = "eDP-1",
	default = true
})

hl.workspace_rule({
	workspace = "3",
	monitor = "eDP-1",
	default = true
})

hl.workspace_rule({
	workspace = "4",
	monitor = "eDP-1",
	default = true
})

hl.workspace_rule({
	workspace = "5",
	monitor = "desc:Philips Consumer Electronics Company 32B1N3800 AU02612012082",
	default = true
})

hl.workspace_rule({
	workspace = "6",
	monitor = "desc:Philips Consumer Electronics Company 32B1N3800 AU02612012082",
	default = true
})

hl.workspace_rule({
	workspace = "7",
	monitor = "desc:Philips Consumer Electronics Company 32B1N3800 AU02612012082",
	default = true
})

hl.workspace_rule({
	workspace = "8",
	monitor = "desc:Philips Consumer Electronics Company 32B1N3800 AU02612012082",
	default = true
})

hl.workspace_rule({
	workspace = "9",
	monitor = "desc:Philips Consumer Electronics Company 32B1N3800 AU02612012082",
	default = true
})
