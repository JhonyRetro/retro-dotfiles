local colors_file = os.getenv("HOME") .. "/.cache/wal/colors-hyprland.lua"
local colors = {}

local f = io.open(colors_file, "r")
if f then
    f:close()
    colors = dofile(colors_file)
else
    hl.dsp.exec_cmd("wal -q -i /tmp/wallpaper")
    f = io.open(colors_file, "r")
    colors = dofile(colors_file)
end

hl.config({
    general = {
        gaps_in = 3,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border = {
                colors = { colors.color1, colors.color2 },
                angle = 45,
            },
            inactive_border = colors.background,
        },


        resize_on_border = true,

        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 0,
        rounding_power = 0,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 0.75,

        shadow = {
            enabled      = false,
        },

        blur = {
            enabled   = true,
            size      = 1,
            passes    = 1,
            vibrancy  = 0.3696,
        },
    },

    animations = {
        enabled = true,
    },
})

hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("md3_standart", { type = "bezier", points = { { 0.2, 0 }, { 0, 1 } } })
hl.curve("md3_decel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("md3_accel", { type = "bezier", points = { { 0.3, 0 }, { 0.8, 0.15 } } })
hl.curve("easeOutExpo", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })

hl.animation({ leaf = "windows", enabled = true, speed = 3, bezier = "md3_decel", style = "popin 60%" })
hl.animation({ leaf = "border", enabled = false })
hl.animation({ leaf = "borderangle", enabled = false })

hl.animation({ leaf = "fade", enabled = true, speed = 2.5, bezier = "md3_decel" })

hl.animation({ leaf = "workspaces", enabled = true, speed = 5.5, bezier = "easeOutExpo", style = "slide" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 1, bezier = "md3_decel", style = "slidefadevert 40%" })

