local wezterm = require("wezterm")

local config = wezterm.config_builder()
local act = wezterm.action
local file = io.open(wezterm.config_dir .. "/colorscheme", "r")
if file then
	config.color_scheme = file:read("*a")
	file:close()
else
	config.color_scheme = "Tokyo Night" -- your default
end

local function is_vim(pane)
	-- This checks if the pane is running vim, nvim, or a similar process
	return pane:get_user_vars().IS_NVIM == "true" or pane:get_foreground_process_name():find("n?vim") ~= nil
end

local function split_nav(key, direction)
	return {
		key = key,
		mods = "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- Pass the key through to Neovim
				win:perform_action({ SendKey = { key = key, mods = "CTRL" } }, pane)
			else
				-- WezTerm handles the movement
				win:perform_action({ ActivatePaneDirection = direction }, pane)
			end
		end),
	}
end

config = {
	leader = {
		key = "a",
		mods = "CTRL",
		timeout_milliseconds = 2000,
	},
	automatically_reload_config = true,
	enable_tab_bar = false,
	window_close_confirmation = "AlwaysPrompt",
	window_decorations = "RESIZE",
	default_cursor_style = "BlinkingBar",
	font = wezterm.font("MesloLGS Nerd Font Mono"),
	scrollback_lines = 3000,
	font_size = 12.5,
	initial_rows = 48,
	initial_cols = 150,
	inactive_pane_hsb = {
		saturation = 0.24,
		brightness = 0.5,
	},
	background = {
		{
			source = {
				File = "/Users/nickbui/.config/wezterm/background_img/astro_background.jpg",
			},
			hsb = {
				hue = 1.0,
				saturation = 1.02,
			},
			width = "100%",
			height = "100%",
			opacity = 0.90,
		},
	},
	window_padding = {
		left = 3,
		right = 3,
		top = 0,
		bottom = 0,
	},
	macos_window_background_blur = 10,
	keys = {
		-- Split horizontally (top/bottom)
		{
			key = "d",
			mods = "CMD|SHIFT",
			action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		-- Split vertically (left/right)
		{
			key = "d",
			mods = "CMD",
			action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		split_nav("h", "Left"),
		split_nav("j", "Down"),
		split_nav("k", "Up"),
		split_nav("l", "Right"),
		-- Send "CTRL-A" to the terminal when pressing CTRL-A, CTRL-A
		{
			key = "a",
			mods = "LEADER",
			action = act.SendKey({ key = "a", mods = "CTRL" }),
		},
		{ key = "c", mods = "LEADER", action = act.ActivateCopyMode },

		{
			key = "x",
			mods = "CTRL",
			action = act.CloseCurrentPane({ confirm = false }),
		},

		{
			key = "z",
			mods = "LEADER",
			action = act.TogglePaneZoomState,
		},
		{
			key = "s",
			mods = "LEADER",
			action = act.RotatePanes("Clockwise"),
		},
		{
			key = "r",
			mods = "LEADER",
			action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }),
		},

		-- Tab keybindings
		{
			key = "n",
			mods = "LEADER",
			action = act.SpawnTab("CurrentPaneDomain"),
		},
		{ key = "[", mods = "LEADER", action = act.ActivateTabRelative(-1) },
		{ key = "]", mods = "LEADER", action = act.ActivateTabRelative(1) },
		{ key = "t", mods = "LEADER", action = act.ShowTabNavigator },

		{ key = "m", mods = "LEADER", action = act.ActivateKeyTable({ name = "move_tab", one_shot = false }) },

		-- Worksspace keybindings
		{ key = "n", mods = "SUPER|SHIFT", action = wezterm.action.SwitchWorkspaceRelative(1) },
		{ key = "w", mods = "LEADER", action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }) },

		--Copy/scroll
		{ key = "f", mods = "SUPER", action = wezterm.action.Search({ CaseInSensitiveString = "" }) },
		{ key = "UpArrow", mods = "SUPER", action = wezterm.action.ScrollByLine(-5) },
		{ key = "DownArrow", mods = "SUPER", action = wezterm.action.ScrollByLine(5) },
		{ key = "c", mods = "SUPER", action = wezterm.action.CopyTo("Clipboard") },
		{ key = "v", mods = "SUPER", action = wezterm.action.PasteFrom("Clipboard") },

		-- Font size
		{ key = "=", mods = "SUPER", action = wezterm.action.IncreaseFontSize },
		{ key = "-", mods = "SUPER", action = wezterm.action.DecreaseFontSize },
		{ key = "0", mods = "SUPER", action = wezterm.action.ResetFontSize },
	},
}

return config
