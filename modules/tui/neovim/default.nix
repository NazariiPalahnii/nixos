{ config, lib, pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    # Добавляем suda.vim для работы с sudo
    plugins = with pkgs.vimPlugins; [
      vim-suda
      catppuccin-nvim
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
    ];

    extraLuaConfig = ''
      -- Custom color palette
      local colors = {
        base = "#1e1e2e",
        mantle = "#181825",
        crust = "#11111b",
        text = "#cdd6f4",
        subtext = "#bac2de",
        mauve = "#cba6f7",
        blue = "#89b4fa",
        teal = "#94e2d5",
        red = "#f38ba8",
        yellow = "#f9e2af",
        green = "#a6e3a1",
        peach = "#fab387",
        overlay0 = "#6c7086",
        surface2 = "#585b70",
      }

      -- Theme setup
      require('catppuccin').setup({
        flavour = "mocha",
        color_overrides = { mocha = colors },
        integrations = {
          cmp = true, nvimtree = true, telescope = true,
          treesitter = true, which_key = true,
        },
        custom_highlights = function(c)
          return {
            LineNr = { fg = c.surface2 },
            CursorLineNr = { fg = c.peach, bold = true },
            VertSplit = { fg = c.surface2 },
            DiagnosticError = { fg = c.red },
            DiagnosticWarn = { fg = c.yellow },
            DiagnosticInfo = { fg = c.blue },
            DiagnosticHint = { fg = c.teal },
            Comment = { fg = c.overlay0, italic = true },
          }
        end,
      })
      vim.cmd.colorscheme("catppuccin")

      -- Basic settings
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true
      vim.opt.cursorline = true
      vim.g.mapleader = ' '

      -- Key mappings
      vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>")
      vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>")
      vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
      vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>")

      -- Sudo write shortcut
      vim.keymap.set("n", "<leader>w", ":SudaWrite<CR>")

      -- NvimTree setup
      require("nvim-tree").setup({
        disable_netrw = true,
        hijack_netrw = true,
        view = { width = 30, side = "left" },
      })

      -- Lualine setup
      require('lualine').setup({
        options = {
          theme = {
            normal = { a = { bg = colors.mauve, fg = colors.base, bold = true }},
            insert = { a = { bg = colors.blue, fg = colors.base, bold = true }},
            visual = { a = { bg = colors.yellow, fg = colors.base, bold = true }},
            replace = { a = { bg = colors.red, fg = colors.base, bold = true }},
          },
        }
      })

      -- Bufferline setup
      require("bufferline").setup({
        highlights = {
          fill = { bg = colors.mantle },
          buffer_selected = { fg = colors.text, bg = colors.base, bold = true },
        }
      })

      -- Telescope setup
      require("telescope").setup({
        defaults = { color_devicons = true }
      })

      -- Treesitter setup
      local parser_dir = vim.fn.stdpath("config") .. "/treesitter-parsers"
      vim.fn.mkdir(parser_dir, "p")
      require'nvim-treesitter.configs'.setup {
        parser_install_dir = parser_dir,
        highlight = { enable = true },
      }
      vim.opt.runtimepath:append(parser_dir)

      vim.cmd(string.format([[
        highlight IndentBlanklineIndent1 guifg=%s
        highlight IndentBlanklineIndent2 guifg=%s
        highlight IndentBlanklineIndent3 guifg=%s
      ]], colors.red, colors.blue, colors.teal))
    '';

    extraConfig = ''
      set scrolloff=8
      set mouse=a
      set clipboard=unnamedplus
      set termguicolors
      set fillchars+=vert:│
    '';
  };
}
