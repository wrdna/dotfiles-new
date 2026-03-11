vim.opt.nu = true

vim.wo.relativenumber = true

vim.opt.cursorline = true
vim.opt.cursorcolumn = true

vim.opt.clipboard = "unnamedplus"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.updatetime = 50

vim.g.mapleader = " "

-- Enable filetype plugins and indentation (if not already enabled)
vim.cmd("filetype plugin indent on")

-- Create an autocommand group (optional but recommended for organization)
vim.api.nvim_create_augroup("JsHtmlIndent", { clear = true })

-- Set indent for JavaScript and HTML files
vim.api.nvim_create_autocmd("FileType", {
  group = "JsHtmlIndent",
  pattern = { "javascript", "html", "javascriptreact"},
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.expandtab = true
  end,
})


