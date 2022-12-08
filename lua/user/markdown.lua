vim.cmd([[
function OpenMarkdownPreview (url)
 silent exe 'silent !open -na "Google Chrome" --args --new-window ' . a:url
endfunction
]])

vim.g.mkdp_browserfunc = "OpenMarkdownPreview"

vim.g.mkdp_browser = "/Applications/Google Chrome.app"
vim.g.mkdp_filetypes = { "markdown", "plantuml" }
vim.g.mkdp_auto_close = 0
