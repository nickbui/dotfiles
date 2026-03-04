return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function(_, opts)
      require("tokyonight").setup({
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      })
      vim.cmd.colorscheme("tokyonight-night")
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
