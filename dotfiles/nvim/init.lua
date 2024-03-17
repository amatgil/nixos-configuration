--- Info ---
-- https://vonheikemen.github.io/devlog/tools/build-your-first-lua-config-for-neovim/ 

--- Options ---
require('options')

--- Keybinds -- 
require('keybinds')

--- Plugins -- 
require('plugins.init-plugins')
require('plugins.lualine')
require('plugins.theme')
require('plugins.blankline')
require('plugins.treesitter')
require('plugins.surround')
require('plugins.nvim-tree')
require('plugins.gitsigns')
require('plugins.telescope')
require('plugins.tmux-integration')
require('plugins.toggleterm')
require('plugins.undotree')
require('plugins.neogit')
require('plugins.parinfer')
-- require('plugins.lsp-zero')
-- require('plugins.lsp-lines')
-- require('plugins.rust-tools')
-- require('plugins.obsidian') --Requires nightly :(
require('plugins.coc-things')
require('plugins.dap')
