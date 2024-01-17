local wezterm = require("wezterm") -- wezterm API

---@class GPU_Spec
---@field webgpu_power_performance string
---@field front_end string

---@return table
---@param a table
---@param b table
local function merge_tables(a, b)
	for k, v in pairs(b) do a[k] = v end
	return a
end

---@return table[string]
local function get_default_prog()
	local def_cmd = {}
	if wezterm.target_triple == "x86_64-pc-windows-msvc" then
		def_cmd = { "ubuntu" }
	end
	if wezterm.target_triple == "x86_64-apple-darwin" then
		def_cmd = {}
	end
	if wezterm.target_triple == "x86_65-unknown-linux-gnu" then
		def_cmd = {}
	end
	return def_cmd
end

---@return GPU_Spec
local function use_interated_gpu()
	local _config = { webgpu_preferred_adapter = "LowPower", front_end = "WebGpu" }
	for _, gpu in ipairs(wezterm.gui.enumerate_gpus()) do
		if gpu.backend == "Vulkan" and gpu.device_type == "IntegratedGpu" then
			_config = {
				webgpu_preferred_adapter = gpu,
				front_end = "WebGpu",
			}
			break
		end
	end
	return _config
end

local gpu = use_interated_gpu()
local colorscheme = require("colorscheme")

local config = {
	-- webgpu_power_performance = "LowPower",
	webgpu_preferred_adapter = gpu.webgpu_power_performance,
	front_end = gpu.front_end,

	-- Shell
	default_prog = get_default_prog(),
	default_domain = "WSL:Ubuntu",

	-- Environment
	-- config.term

	-- Window
	hide_tab_bar_if_only_one_tab = true,
	inactive_pane_hsb = { saturation = 0.9, brightness = 0.8 },
	window_background_opacity = 0.95,

	-- Fonts
	font = wezterm.font("CaskaydiaCove Nerd Font Mono", { stretch = "Expanded", weight = "Regular" }),
	font_size = 10,

	-- Colors
	color_scheme = colorscheme.color_scheme,
	color_schemes = colorscheme.color_schemes,

	-- Selection

	-- Cursor
	default_cursor_style = "BlinkingBar",
}

return merge_tables(wezterm.config_builder(), config)
