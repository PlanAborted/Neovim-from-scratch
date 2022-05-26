vim.cmd([[
try
  colorscheme tokyonight
  " colorscheme catppuccin
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]])
