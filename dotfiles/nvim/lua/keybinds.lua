--- vim.keymap.set({mode}, {lhs}, {rhs}, {opts}) --- 
-- (possible modes: n, i, v(visual + selection), t(term), ''(empty, equiv. n + v + o -- 

vim.keymap.set('n', '<leader>w', '<cmd>write<cr>', {desc = 'Save'})
vim.keymap.set({'n', 'x'}, '<leader>y', '"+y') -- Use sys clipboard (yank)
vim.keymap.set({'n', 'x'}, '<leader>p', '"+p') -- Use sys clipboard (paste)

vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<cr>')
vim.keymap.set('n', '<leader>o', ':NvimTreeFocus<cr>') 

vim.keymap.set('n', '<leader>th', ':CocCommand document.toggleInlayHint<cr>') 

vim.keymap.set('n', '<leader>t', ':TSNode:tree<cr>') 

vim.keymap.set('n', '<leader>ss', ':SymbolsOutline<cr>')

vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle)
vim.keymap.set('n', '<leader>g', ':Neogit<cr>')
vim.keymap.set('n', '<leader>ls', ':vlime-mappings-invoke-server-rr<cr>') -- Start vlime server for lisp

vim.keymap.set('n', '<leader>ff', ':Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<cr>')
vim.keymap.set('n', '<leader>fh', ':Telescope help_tags<cr>')
vim.keymap.set('n', '<leader>rf', ":checktime<cr>")


--Dap
vim.keymap.set('n', '<leader>db', '<cmd>lua require"dap".toggle_breakpoint()<cr>', {desc = 'Toggle Breakpoint'})
vim.keymap.set('n', '<leader>dc', '<cmd>lua require"dap".continue()<cr>', {desc = 'Continue'})
vim.keymap.set('n', '<leader>do', '<cmd>lua require"dap".step_over()<cr>', {desc = 'Step over'})
vim.keymap.set('n', '<leader>di', '<cmd>lua require"dap".step_into()<cr>', {desc = 'Step into'})
vim.keymap.set('n', '<leader>ds', '<cmd>lua require"dap".repl.open()()<cr>', {desc = 'Open repl'})
vim.keymap.set('n', '<leader>dp', '<cmd>lua require"dap".ui.widgets.hover()<cr>', {desc = 'See value under expression'})
