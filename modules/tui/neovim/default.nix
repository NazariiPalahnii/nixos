{ config, lib, pkgs, ... }:
{
  programs.neovim = {
    coc.enable = true;
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;

    plugins = with pkgs.vimPlugins; [
      cord-nvim
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
      
      # Coc плагины
      coc-ultisnips
      coc-snippets
      coc-json
      coc-pyright
      coc-sh
      coc-css
      coc-html
      coc-prettier
      coc-tsserver
      coc-rust-analyzer
    ];

    extraLuaConfig = ''
      -- Кастомная палитра цветов
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

      -- Настройка темы
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

      -- Базовые настройки
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.tabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true
      vim.opt.cursorline = true
      vim.g.mapleader = ' '

      -- Горячие клавиши
      vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>")
      vim.keymap.set("n", "<leader>e", ":NvimTreeFocus<CR>")
      vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
      vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>")

      -- Настройка NvimTree
      require("nvim-tree").setup({
        disable_netrw = true,
        hijack_netrw = true,
        view = { width = 30, side = "left" },
      })

      -- Настройка Lualine
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

      -- Настройка Bufferline
      require("bufferline").setup({
        highlights = {
          fill = { bg = colors.mantle },
          buffer_selected = { fg = colors.text, bg = colors.base, bold = true },
        }
      })

      -- Настройка Telescope
      require("telescope").setup({
        defaults = { color_devicons = true }
      })

      -- Настройка Treesitter
      local parser_dir = vim.fn.stdpath("config") .. "/treesitter-parsers"
      vim.fn.mkdir(parser_dir, "p")
      require'nvim-treesitter.configs'.setup {
        parser_install_dir = parser_dir,
        highlight = { enable = true },
      }
      vim.opt.runtimepath:append(parser_dir)

      -- Подсветка отступов
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
