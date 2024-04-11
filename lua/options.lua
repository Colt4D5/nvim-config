-- line number config
vim.opt.nu = true
vim.opt.relativenumber = true

-- where to open up a new window
vim.opt.splitbelow = true
vim.opt.splitright = true

-- tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.hidden = true

-- which python host
vim.g.python3_host_prog = '/Users/jasonsprinkle/.pyenv/versions/py3nvim/bin/python'

-- folds
vim.opt.foldmethod = "indent"
vim.opt.foldenable = false

-- some keymaps
vim.keymap.set("n", "[w", "<C-w>W")
vim.keymap.set("n", "]w", "<C-w>w")
vim.keymap.set("n", "[q", ":cprev<cr>")
vim.keymap.set("n", "]q", ":cnext<cr>")

-- if we're in a django project, always set these html files to be htmldjango
vim.api.nvim_create_autocmd({
    "BufNewFile",
    "BufRead"
}, {
    pattern = { "*.html" },
    callback = function()
        local buf = vim.api.nvim_get_current_buf()
        -- if this is an html file in a django project, then we should
        -- automatically set the filetype to such
        if vim.api.nvim_buf_get_name(buf):match("djangoproject") then
            vim.api.nvim_buf_set_option(buf, "filetype", "htmldjango")
        end
    end
})

vim.opt.termguicolors = true

-- want the buffer number and the filename
vim.opt.winbar = "%n %f"

vim.g.mapleader = " "
