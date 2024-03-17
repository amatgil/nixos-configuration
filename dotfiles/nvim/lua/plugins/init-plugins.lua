local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim' -- :echo stdpath('data') . '/site/pack/packer'
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	print('Installing packer...')
	local packer_url = 'https://github.com/wbthomason/packer.nvim'
	vim.fn.system({'git', 'clone', '--depth', '1', packer_url, install_path})
	print('Done.')

	vim.cmd('packadd packer.nvim')
	install_plugins = true
end

require('packer').startup(function(use)
	--- List of packages
	-- Package manager (will update itself if in list)
	use 'wbthomason/packer.nvim'
	-- Theme inspired by Atom
	use 'joshdick/onedark.vim'
	-- Theme 
	use { "catppuccin/nvim", as = "catppuccin" }
	-- Statusline
	use 'nvim-lualine/lualine.nvim'
	-- s p e e d
	use 'ggandor/lightspeed.nvim'
	-- themes
	use 'folke/tokyonight.nvim'
	-- indent guides
	use { 'lukas-reineke/indent-blankline.nvim'}
	-- for other plugins
	use 'nvim-treesitter/nvim-treesitter'
	use 'nvim-lua/plenary.nvim'
	-- surround
	use 'tpope/vim-surround'
	-- latex
	use { 'lervag/vimtex', lazy = false } -- TODO: aixo
	-- Lisp 
	use 'vlime/vlime'
	--use 'gpanders/nvim-parinfer'
	use { 'dundalek/parpar.nvim', requires = { "gpanders/nvim-parinfer", "julienvincent/nvim-paredit" }}
	-- Git 
	use 'lewis6991/gitsigns.nvim' -- on the left
	-- use 'tpope/vim-fugitive' -- commands
	use { 'NeogitOrg/neogit', requires = { 'nvim-lua/plenary.nvim', "sindrets/diffview.nvim" }} -- Magit
	-- Undo tree :D
	use 'mbbill/undotree'
	-- t e l e s c o p e
	use 'nvim-telescope/telescope.nvim'
	use 'nvim-telescope/telescope-fzf-native.nvim'
	-- justfiles
	use 'NoahTheDuke/vim-just'
	-- floating UI term
	use 'akinsho/toggleterm.nvim'
	--  t r e e
	use 'kyazdani42/nvim-tree.lua'
	-- For symbols outline
	use 'simrat39/symbols-outline.nvim'
	-- tmux integration
	use { 'christoomey/vim-tmux-navigator', lazy = false }
	-- elm
	use 'elmcast/elm-vim'
	-- haskell stuffs

	use { 'mrcjkb/haskell-tools.nvim', version = '^3', -- Recommended
	  ft = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
	}
	use 'alx741/vim-hindent' -- autoindent on save


	-- Render out text colors (don't think it works)
	--use 'chrisbra/Colorizer'

	-- Autocompletion
	--use { 'hrsh7th/nvim-cmp', config = [[require('config.nvim-cmp')]] }    
	--use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' } 
	--use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' }        -- buffer auto-completion
	--use { 'hrsh7th/cmp-path', after = 'nvim-cmp' }          -- path auto-completion
	--use { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' }       -- cmdline auto-completion
	--use 'L3MON4D3/LuaSnip'
	--use 'saadparwaiz1/cmp_luasnip'

	-- LSP (autocomplete), but seems better (even if it uses node, sadly)
	use {'neoclide/coc.nvim', branch = 'release'}

	-- Debug Adapter Protocol
	use 'mfussenegger/nvim-dap'
	use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap"} }

	-- KDL, for zellij
	--use 'imsnif/kdl.vim'



	-- -- LSP
	-- use 'neovim/nvim-lspconfig'
 	-- use 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
	-- use 'hrsh7th/nvim-cmp'
	-- use 'hrsh7th/cmp-buffer'
	-- use 'hrsh7th/cmp-path'
	-- use 'simrat39/rust-tools.nvim'
	-- use 'saadparwaiz1/cmp_luasnip'
	-- use 'hrsh7th/cmp-nvim-lsp'
	-- use 'L3MON4D3/LuaSnip'
	-- use 'rafamadriz/friendly-snippets'
	-- -- use 'smjonas/inc-rename.nvim' --Also requires nightly (bloody hell)
	-- use {
	--   'VonHeikemen/lsp-zero.nvim',
	--   requires = {
	--     -- LSP Support
	--     {'neovim/nvim-lspconfig'},
	--     {'williamboman/mason.nvim'},
	--     {'williamboman/mason-lspconfig.nvim'},
	-- 
	--     -- Autocompletion
	--     {'hrsh7th/nvim-cmp'},
	--     {'hrsh7th/cmp-buffer'},
	--     {'hrsh7th/cmp-path'},
	--     {'saadparwaiz1/cmp_luasnip'},
	--     {'hrsh7th/cmp-nvim-lsp'},
	--     {'hrsh7th/cmp-nvim-lua'},
	-- 
	--     -- Snippets
	--     {'L3MON4D3/LuaSnip'},
	--     {'rafamadriz/friendly-snippets'},
	--   }
	-- }

	if install_plugins then
	  require('packer').sync()
	end
end)

if install_plugins then
  return
end
