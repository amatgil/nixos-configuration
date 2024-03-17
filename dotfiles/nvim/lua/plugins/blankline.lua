vim.opt.list = true
vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:↴" -- Not really visible

require("ibl").setup {
    -- show_end_of_line = true,
    -- 'ibl.config.indent.char' was space
	--use_treesitter = true,
	scope = {
		enabled = true,
		show_start = true;
	};
	--show_current_context = true -- Should highlight current indent
}
