local ok, toggleterm = pcall(require, 'toggleterm')
if not ok then return end

toggleterm.setup({
   open_mapping = [[<C-b>]],
   hide_numbers = true,
   shade_filetypes = {},
   shade_terminal = true,
   shading_factor = 2,
   start_in_insert = true,
   insert_mapping = true,
   terminal_mapping = true,
   persist_size = true,
   autochdir = true,
   direction = 'horizontal',
   close_on_exit = true,
   shell = '/usr/bin/zsh',
   float_opts = {
      border = 'curved',
      winblend = 0,
      highlightes = {
         border = 'Normal',
         background = 'Normal'
      }
   }
})
-- set
---- autocmd TermEnter term://*toggleterm#*
----       \ tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
---- 
---- -- By applying the mappings this way you can pass a count to your
---- -- mapping to open a specific window.
---- -- For example: 2<C-t> will open terminal 2
---- nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
---- inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>

function _G.set_terminal_keymaps()
  local opts = {buffer = 0}
  vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
  vim.keymap.set('t', '<C-w>h>', [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set('t', '<C-w>j', [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set('t', '<C-w>k', [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set('t', '<C-w>l', [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set('t', '<leader>t', ':ToggleTerm size=10 dir=~/tmp/toggle-term-tmp-dir direction=horizontal<cr>')
end
vim.keymap.set({'n', 'x'}, '<leader>t', ':ToggleTerm size=10 dir=~/tmp/toggle-term-tmp-dir direction=horizontal<cr>')

 -- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
