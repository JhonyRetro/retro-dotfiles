local terminal    = "kitty"
local fileManager = "thunar"
local menu = "rofi -show drun -show-icons -theme-str 'element-icon { size: 8ch; }'"
local editor = "nvim"
local webBrowser = "google-chrome-stable"

local mainMod = "SUPER"

-- Window control binds
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind("ALT + F4", hl.dsp.window.close(), { release = true })
hl.bind(mainMod .. " + Delete", hl.dsp.exec_cmd("uwsm stop"))
hl.bind(mainMod .. " + W", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + G", hl.dsp.group.toggle())
hl.bind("SHIFT + F11", hl.dsp.window.fullscreen({action = toggle}), { release = true })
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

-- Window and workspace related binds
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))
hl.bind("ALT + Tab", hl.dsp.exec_cmd("snappy-switcher next --mod alt"), { release = true })

hl.bind(mainMod .. "+ CONTROL + left",  hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. "+ CONTROL + right", hl.dsp.focus({ workspace = "r+1" }))
-- Window resize
hl.bind(mainMod .. "+ SHIFT + right",  hl.dsp.window.resize({ x = 30, y = 0, relative = true }))
hl.bind(mainMod .. "+ SHIFT + left",  hl.dsp.window.resize({ x = -30, y = 0, relative = true }))
hl.bind(mainMod .. "+ SHIFT + up",  hl.dsp.window.resize({ x = 0, y = -30, relative = true }))
hl.bind(mainMod .. "+ SHIFT + down",  hl.dsp.window.resize({ x = 0, y = 30, relative = true }))
-- Move active window in a direction
hl.bind(mainMod .. "+ CONTROL + SHIFT + left", hl.dsp.window.move({ direction = "left"}))
hl.bind(mainMod .. "+ CONTROL + SHIFT + right", hl.dsp.window.move({ direction = "right"}))
hl.bind(mainMod .. "+ CONTROL + SHIFT + up", hl.dsp.window.move({ direction = "up"}))
hl.bind(mainMod .. "+ CONTROL + SHIFT + down", hl.dsp.window.move({ direction = "down"}))
-- Move to workspace 'i'
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + ALT + " .. key, hl.dsp.window.move({ workspace = i, follow = false})) 
end
-- Scratchpad
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
-- Mouse controls
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


-- App specific binds
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(terminal .. " " .. editor))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(webBrowser))
hl.bind("CONTROL + SHIFT + Escape", hl.dsp.exec_cmd(terminal .. " htop", {float = true}))

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("ashell msg volume-up"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("ashell msg volume-down"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("ashell msg volume-toggle-mute"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("ashell msg microphone-toggle-mute"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("ashell msg brightness-up"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("ashell msg brightness-down"), { locked = true, repeating = true })
hl.bind("XF86RFKill", hl.dsp.exec_cmd("ashell msg toggle-airplane-mode"), { locked = true, repeating = true})
hl.bind("XF86Launch1", hl.dsp.exec_cmd("ashell msg toggle-idle-inhibitor"), { locked = true, repeating = true})
-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"), { locked = true })

hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m region"), { release = true })
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprpicker -an"))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("$HOME/.config/hypr/hyprlock/scripts/lock.sh"))
hl.bind("switch:[Lid Switch]", hl.dsp.exec_cmd("systemctl suspend"))

hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("$HOME/.config/hypr/wallpapers/wallpaper_select.sh"))

