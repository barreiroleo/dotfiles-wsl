local wezterm = require("wezterm")
local update_status = require("update-status")
local colors = require("colors")
local keymaps = require("keymaps")

local config = wezterm.config_builder()

-- Colorscheme
config.color_scheme = 'Colorful Colors (terminal.sexy)'

-- Tabs
-- config.enable_wayland = true
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.colors = colors

-- Window
config.window_background_opacity = 1
config.window_padding = { left = 2, right = 2, top = 2, bottom = 2, }

-- Fonts
config.font = wezterm.font("JetBrainsMono Nerd Font Propo", { weight = "Medium" })
-- font = wezterm.font("Maple Mono NF", { weight = "Regular" }),
-- font = wezterm.font("VictorMono Nerd Font Propo" ),
config.font_size = 9.5
config.line_height = 1.00

-- Keybindings
config.leader = keymaps.leader
config.keys = keymaps.keys
config.key_tables = keymaps.key_tables


wezterm.on('update-status', function(window, pane)
    update_status(window, pane)
end)

return config
