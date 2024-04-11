return {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    {
        "oxfist/night-owl.nvim",
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            -- vim.cmd.colorscheme("night-owl")
        end,
    },
    {
        "neanias/everforest-nvim",
        version = false,
        lazy = false,
        priority = 1000, -- make sure to load this before all the other start plugins
        -- Optional; default configuration will be used if setup isn't called.
        config = function()
            require("everforest").setup({
                vim.cmd.colorscheme("everforest")
            })
        end,
    },
    {
        "mbbill/undotree",
        keys = {
            { "<leader>u", vim.cmd.UndotreeToggle }
        }
    },

    -- git plugins
    {
        "tpope/vim-fugitive",
        lazy = false,
        keys = {
            { "<leader>gs", vim.cmd.Git }
        }
    },

    {
        "f-person/git-blame.nvim",
        config = function()
            -- git blame
            vim.g.gitblame_display_virtual_text = 0 -- Disable virtual text
        end
    },
    "airblade/vim-gitgutter",

    -- visual help with tabs and spaces
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {
            indent = {
                char = "¦"
            },
            exclude = {
                filetypes = {
                    "alpha"
                }
            }
        }
    },

    -- statusline plugin
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "f-person/git-blame.nvim",
        },
        config = function()
            local lualine = require("lualine")
            local gitblame = require("gitblame")
            lualine.setup {
                options = {
                    globalstatus = true
                },
                sections = {
                    lualine_x = {
                        {
                            gitblame.get_current_blame_text,
                            cond = gitblame.is_blame_text_available,
                            fmt = function(str)
                                return str:sub(1, 75)
                            end
                        },
                        'encoding', 'fileformat', 'filetype'
                    }
                },
            }
        end
    },

    -- that sweet sweet surround plugin
    {
        "tpope/vim-surround",
        config = function()
            vim.g.surround_115 = "**\r**"  -- 115 is the ASCII code for 's'
            vim.g.surround_47 = "/* \r */" -- 47 is /
        end
    },

    { "numToStr/Comment.nvim", config = true, },
    { "windwp/nvim-autopairs", config = true },

    -- session management
    {
        "Shatur/neovim-session-manager",
        config = function()
            local config = require('session_manager.config')

            -- don't automatically load up previous session
            -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
            require('session_manager').setup({
                autoload_mode = config.AutoloadMode.Disabled,
            })
        end
    },


    -- helps with repeating thing
    "tpope/vim-repeat",

    -- taking a beeg leap here
    {
        "ggandor/leap.nvim",
        -- one two three repeater!
        dependencies = { "tpope/vim-repeat" },
        config = function()
            local leap = require('leap')
            leap.add_default_mappings()
            leap.opts.highlight_unlabeled_phase_one_targets = true
        end
    },

    -- autodetecting of tab widths and such
    "tpope/vim-sleuth",

    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    -- diagnostics
                    null_ls.builtins.diagnostics.djlint.with({
                        prefer_local = true,
                        extra_args = {
                            "--profile=django",
                        }
                    }),
                    null_ls.builtins.formatting.djlint.with({ prefer_local = true, extra_args = { "--profile=django" } }),
                    null_ls.builtins.formatting.prettier.with({ prefer_local = true })
                },
            })
        end
    },

    -- oil, not vinegar
    {
        "stevearc/oil.nvim",
        config = function()
            require('oil').setup({
                view_options = {
                    show_hidden = true
                }
            })
            vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
        end
    },
}, {}
