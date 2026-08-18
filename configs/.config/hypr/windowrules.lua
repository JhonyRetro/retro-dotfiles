hl.window_rule({ idle_inhibit = "fullscreen", match = { class = "^(.*celluloid.*)$|^(.*mpv.*)$|^(.*vlc.*)$"} })
hl.window_rule({ idle_inhibit = "fullscreen", match = { class = "^(.*[Ss]potify.*)$"} })
hl.window_rule({ idle_inhibit = "fullscreen", match = { class = "^(.*LibreWolf.*)$|^(.*floorp.*)$|^(.*brave-browser.*)$|^(.*firefox.*)$|^(.*chromium.*)$|^(.*zen.*)$|^(.*vivaldi.*)$"} })

hl.window_rule({ match = { class = "^(blueman-manager)$" }, float = true })
hl.window_rule({ match = { initial_class = "^(thunar)$" }, float = true })
hl.window_rule({ match = { class = "^(org.xfce.thunar)$", title = "^(File Operation Progress)$"}, float = true})
hl.window_rule({ match = { class = "^(org.xfce.thunar)$", title = "^(.*Properties.*)$"}, float = true})
hl.window_rule({ match = { class = "^(nm-).*$" }, float = true })
hl.window_rule({ match = { class = "^(hyprpolkitagent)$" }, float = true })
hl.window_rule({ match = { class = "^(nwg-look)$" }, float = true })
hl.window_rule({ match = { class = "^(kvantummanager)$" }, float = true })
hl.window_rule({ match = { class = "^.*(pavucontrol).*$" }, float = true })
hl.window_rule({ match = { class = "^(qt)[5,6](ct)$" }, float = true })

local suppressMaximizeRule = hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})
