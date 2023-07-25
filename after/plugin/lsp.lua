local lsp = require("lsp-zero")
local lspconfig = require("lspconfig")

lsp.preset('recommended')

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr }
    lsp.default_keymaps(opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lspconfig.tailwindcss.setup({
    init_options = {
        userLanguages = {
            htmldjango = "html"
        }
    }
})

lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

lspconfig.pylsp.setup {
    settings = {
        pylsp = {
            configurationSources = { 'flake8' },
            plugins = {
                -- we don't care about these, we use flake8
                pycodestyle = { enabled = false },
                mccabe = { enabled = false },
                pyflakes = { enabled = false },

                -- literati related config
                flake8 = {
                    enabled = false,
                },
            }
        }
    }
}

lsp.format_mapping("pf", {
    format_opts = {
        async = false,
        timeout_ms = 10000
    },
    servers = {
        ["null-ls"] = { 'python', 'htmldjango' },
        ['lua_ls'] = { 'lua' },
    }
})

lsp.setup()

-- setup using enter for autocomplete selection
local cmp = require('cmp')
cmp.setup({
    mapping = {
        -- setting select to true means it will select the first item
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    enabled = function()
        -- it was getting annoying to see cmp work inside comments, this disables that
        local in_prompt = vim.api.nvim_buf_get_option(0, 'buftype') == 'prompt'
        if in_prompt then -- this will disable cmp in the Telescope window (taken from the default config)
            return false
        end
        local context = require("cmp.config.context")
        return not (context.in_treesitter_capture("comment") == true or context.in_syntax_group("Comment"))
    end
})

-- use null ls to setup formatting and diagnostics
local null_ls = require("null-ls")
null_ls.setup({
    should_attach = function(bufnr)
        -- I want to always ignore formatting / diagnostics in packages
        -- this was breaking mypy which was annoying. Turns out, I just
        -- it's better to not care about things we shouldn't care about
        return not vim.api.nvim_buf_get_name(bufnr):match(".pyenv")
    end,
    debug = true,
    sources = {
        -- diagnostics
        null_ls.builtins.diagnostics.flake8.with({ prefer_local = true }),
        null_ls.builtins.diagnostics.djlint.with({
            prefer_local = true,
            extra_args = {
                "--profile=django",
            }
        }),
        null_ls.builtins.diagnostics.mypy.with({
            prefer_local = true,
            extra_args = {
                "--check-untyped-defs",
                "--ignore-missing-imports",
            },
            timeout = 10000
        }),
        -- formatting
        null_ls.builtins.formatting.black.with({ prefer_local = true }),
        null_ls.builtins.formatting.isort.with({ prefer_local = true }),
        null_ls.builtins.formatting.prettier.with({ prefer_local = true }),
        null_ls.builtins.formatting.djlint.with({ prefer_local = true })
    },
})
