vim.opt.showmode = false -- So vim doesn't show the mode, lualine already does it

require('lualine').setup({
	options = {
		icons_enabled = true,
		path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
	}
})

