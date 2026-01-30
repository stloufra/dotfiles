vim.opt.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.expandtab = true
vim.opt.backup = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.opt.history = 1000
vim.opt.wildmenu = true
vim.opt.wildignore = '*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx'
vim.o.termguicolors = true

vim.g.mapleader = " " 

-- Cursor shape
vim.cmd[[
  let &t_SI = "\e[6 q"
  let &t_EI = "\e[3 q"
]]

vim.opt.guicursor = {
  "n-v-c:block-Cursor/lCursor",           -- Normal, visual, command: block cursor
  "i-ci-ve:ver25-Cursor/lCursor",         -- Insert: vertical bar (25% width)
  "r-cr:hor20-Cursor/lCursor",            -- Replace: horizontal bar (20% height)
  "o:hor50-Cursor/lCursor",               -- Operator-pending: horizontal bar (50% height)
  "a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor", -- All modes: blink settings
  "sm:block-Cursor/lCursor-blinkwait175-blinkoff150-blinkon175", -- Showmatch: block with blink
}

-- Highlight modified lines with git signs
vim.cmd([[
  sign define GitGutterAdd    text=│ texthl=GitGutterAdd
  sign define GitGutterChange text=│ texthl=GitGutterChange
  sign define GitGutterDelete text=_ texthl=GitGutterDelete
]])

-- Jump to the last position when reopening a file
vim.cmd([[
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   execute "normal! g'\"" |
    \ endif
]])

vim.cmd([[ inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<CR>" ]])
vim.keymap.set('i', 'jj', '<Esc>')
vim.keymap.set('n', '<space>', ':')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-l>', '<C-w>l')
vim.keymap.set('n', '<F2>', ':w<CR>')
vim.keymap.set('n', '<F4>', ':wq<CR>')
vim.keymap.set('n', '<F3>', ':q<CR>')
vim.keymap.set('n', '<F5>', ':q!<CR>')
vim.keymap.set('n', '<U>', '<C-r>')


-- Setup Lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "neoclide/coc.nvim", branch = "release", build = "npm ci" },
  { "olimorris/onedarkpro.nvim" },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzf-native.nvim", build = "make" }},
  { "nvim-lualine/lualine.nvim",
    dependencies = { 'nvim-tree/nvim-web-devicons' } },
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "neovim/nvim-lspconfig" },
  { --Git status bars next to the line nuber
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup {
      signs = {
        add          = { text = '│' },
        change       = { text = '│' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
      },
    }
  end,
  },
  { "codota/tabnine-nvim",
    run = "./dl_binaries.sh"  },   
    {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter" },
    { "nvim-lua/plenary.nvim" },
  },
  config = function()
    require('refactoring').setup({})
  end
}
})  

-- Theme
vim.cmd.colorscheme( 'onedark_vivid')

-- Lualine
require('lualine').setup({
  options = {
    theme = 'onedark',
    section_separators = '',
    component_separators = ''
  }
})

-- Treesitter
require("nvim-treesitter.configs").setup {
  highlight = {
    enable = true,
  },
}

-- Telescope
require("telescope").setup()
require('telescope').load_extension('fzf')

-- Telescope keymaps for fzf-like functionality
vim.keymap.set('n', '<C-t>', require('telescope.builtin').find_files)
vim.keymap.set('n', '<C-r>', require('telescope.builtin').buffers)
vim.keymap.set('n', '<leader><leader>', require('telescope.builtin').live_grep, {
  desc = "Search with Telescope (double leader)"
})



-- Enable enter to confirm suggestion and arrow navigation
vim.cmd([[
  nmap gd <Plug>(coc-definition)
  nmap gi <Plug>(coc-implementation)
  nmap gr <Plug>(coc-references)
]])

-- To accept suggestion from ClangD just Alt+Enter
vim.keymap.set("n", "<M-CR>", function()
  vim.fn.CocAction('codeAction')
end, { noremap = true, silent = true })

vim.keymap.set("x", "<M-CR>", function()
  vim.fn.CocAction('codeAction')
end, { noremap = true, silent = true })

require('tabnine').setup({
  disable_auto_comment=true,
  accept_keymap="<F13>",
  dismiss_keymap = "<C-]>",
  debounce_ms = 800,
  suggestion_color = {gui = "#808080", cterm = 244},
  exclude_filetypes = {"TelescopePrompt", "NvimTree"},
  log_file_path = nil, -- absolute path to Tabnine log file
  ignore_certificate_errors = false,
  -- workspace_folders = {
  --   paths = { "/your/project" },
  --   get_paths = function()
  --       return { "/your/project" }
  --   end,
  -- },
})

require('lualine').setup({
   -- tabline = {
   --     lualine_a = {},
   --     lualine_b = {'branch'},
   --     lualine_c = {'filename'},
   --     lualine_x = {},
   --     lualine_y = {},
   --     lualine_z = {}
   -- },
    sections = { lualine_x = {'tabnine','fileformat', 'filetype'}}
})

vim.keymap.set("v", "<leader>re", function()
  require('refactoring').refactor("Extract Function")
end, { desc = "Extract function", noremap = true })

vim.keymap.set("v", "<leader>rv", function()
  require('refactoring').refactor("Extract Variable")
end, { desc = "Extract variable", noremap = true })

