{ config, lib, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      onedark-nvim
      lualine-nvim
      bufferline-nvim
      nvim-tree-lua
      nvim-web-devicons
      telescope-nvim
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp_luasnip
      lspkind-nvim
      nvim-treesitter.withAllGrammars
      nvim-autopairs
      comment-nvim
      which-key-nvim
      indent-blankline-nvim
    ];

    extraLuaConfig = ''
      -- Цветовая схема
      require('onedark').setup({
        style = 'dark',
        highlights = {
          LineNr = { fg = '#5c6370', bg = 'none' },
          CursorLineNr = { fg = '#e5c07b', bg = 'none' },
        }
      })
      vim.cmd.colorscheme("onedark")

      -- Основные настройки
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true
      vim.opt.smartindent = true
      vim.g.mapleader = ' '

      -- Горячие клавиши (ваши старые пинды)
      vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>")
      vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>")
      vim.keymap.set("n", "<leader>bd", ":bd<CR>")
      vim.keymap.set("n", "<leader>bo", ":%bd|e#|bd#<CR>")
      vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
      vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>")
      vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>")
      vim.keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>")

      -- Настройка NvimTree (как у вас было)
      require("nvim-tree").setup({
        disable_netrw = true,
        hijack_netrw = true,
        open_on_tab = false,
        update_cwd = true,
        diagnostics = {
          enable = true,
          icons = { hint = "", info = "", warning = "", error = "" },
        },
        filters = { dotfiles = false, custom = { "node_modules", ".cache" } },
        view = {
          width = 30,
          side = "left",
        },
        renderer = {
          indent_markers = {
            enable = true,
            icons = {
              corner = "└ ",
              edge = "│ ",
              item = "│ ",
              none = "  ",
            },
          },
          icons = {
            webdev_colors = true,
            git_placement = "before",
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
            },
          },
        },
      })

      -- Остальные настройки...
      require("bufferline").setup({})
      require('lualine').setup({})
      require("telescope").setup({})
    '';

    extraConfig = ''
      set scrolloff=8
      set mouse=a
      set clipboard=unnamedplus
      highlight VertSplit gui=NONE cterm=NONE
    '';
  };
}
