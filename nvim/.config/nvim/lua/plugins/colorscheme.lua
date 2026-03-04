return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function(opts)
      require("tokyonight").setup({
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      })
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  { "catppuccin/nvim", name = "catppuccin", lazy = true },
  {
    "ellisonleao/gruvbox.nvim",
    lazy = true,
    config = function()
      vim.o.background = "dark"
    end,
  },
}
