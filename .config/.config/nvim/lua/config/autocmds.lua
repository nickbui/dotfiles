-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("wezterm_colorscheme", { clear = true }),
  callback = function(args)
    local colorschemes = {
      ["tokyonight-night"] = "Tokyo Night",
      ["tokyonight-storm"] = "Tokyo Night Storm",
      ["tokyonight-day"] = "Tokyo Night Day",
      ["catppuccin-frappe"] = "Catppuccin Frappe",
      ["catppuccin-latte"] = "Catppuccin Latte",
      ["catppuccin-macchiato"] = "Catppuccin Macchiato",
      ["catppuccin-mocha"] = "Catppuccin Mocha",
      ["gruvbox"] = "GruvboxDark",
    }
    local colorscheme = colorschemes[args.match]
    if not colorscheme then
      return
    end

    local filename = vim.fn.expand("~/.config/wezterm/colorscheme")
    local file = io.open(filename, "w")
    assert(file)
    file:write(colorscheme)
    file:close()
    vim.notify("Setting WezTerm color scheme to " .. colorscheme, vim.log.levels.INFO)
  end,
})
