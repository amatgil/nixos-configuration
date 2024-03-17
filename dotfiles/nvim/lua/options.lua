vim.g.mapleader = " "
-- vim.g.LanguageClient_diagnosticsEnable = 0 TODO: Figure out how to disable gutter

vim.opt.colorcolumn='100' -- Visual column, to not write an entire encyclopedia per line
vim.opt.clipboard=unnamed -- Always use sys clipboard (testing it out)
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a" -- 'all modes'
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false -- Highlight after search
vim.opt.showbreak = "<+>"
vim.opt.winfixwidth = true-- Stop auto-resize on save
vim.opt.winfixheight = true -- Stop auto-resize on save
vim.opt.autoread = true -- Reload file on third-party change
vim.opt.undofile = true -- S'enten, no? `:h persistent_undo`, si no
vim.opt.undodir = vim.fn.expand('~/.cache/nvim/undodir/') -- S'enten, no? `:h persistent_undo`, si no
vim.opt.title = true
vim.opt.titlestring = "%(%{expand(\"%:~:.:h\")}%)/%t"
vim.opt.cursorline = true
vim.opt.autoread = true
vim.opt.nrformats:append('alpha')
vim.g.elm_setup_keybindings = 0
-- vim.o.ch = 0 -- Hide commandline until you input command
-- vim.g.neovide_scroll_animation_length = 0.3

--- Haskell ---
-- Indentation block
--vim.g.hident_ident_size = 4
--vim.g.hindent_line_length = 100
--vim.g.hindent_command = "stack exec -- hindent"

--- Tabs ---
vim.opt.autoindent = true -- Automatic indentation alignment
vim.opt.expandtab = false -- true means spaces only, false means tabs
vim.opt.tabstop = 4 -- Tab size
vim.opt.shiftwidth = 0 -- When using '>>', '<<' or '=='. 0 means replicate tabstop

--- Folds ---
vim.opt.foldcolumn = "3" -- Show folds in a column on the left. Number indicates col width

--- GUI ---
vim.opt.termguicolors = true
vim.opt.guifont='Iosevka:h12' -- My beloved
--vim.g.neovide_scale_factor = 0.80 -- Font size
--vim.opt.guifont = 'Monaspace Krypton'

--- LSP ---
vim.opt.completeopt = {'menu', 'menuone', 'noselect'}
vim.api.nvim_create_autocmd("FileType", {
	pattern = "html",
	command = "setlocal expandtab shiftwidth=2 tabstop=2"
})
vim.api.nvim_create_autocmd("FileType", {
	pattern = "css",
	command = "setlocal expandtab shiftwidth=2 tabstop=2"
})
