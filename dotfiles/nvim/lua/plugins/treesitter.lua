require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
	disable = { "css", "clojure" }, -- list of language that will be disabled
  },
	ensure_installed = {
    'python',
    'rust',
    'latex',
    'lua',
	'comment'
  },
})
