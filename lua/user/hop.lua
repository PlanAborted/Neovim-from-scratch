local status_ok, hop = pcall(require, "hop")
if not status_ok then
  return
end

vim.cmd("hi HopNextKey guifg=#ff9900")
vim.cmd("hi HopNextKey1 guifg=#ff9900")
vim.cmd("hi HopNextKey2 guifg=#ff9900")
hop.setup()
