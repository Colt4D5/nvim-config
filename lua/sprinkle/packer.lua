-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use { 'wbthomason/packer.nvim' }

    -- I think this is a bunch of helper functions
    use { 'nvim-lua/plenary.nvim' }

    -- the lil icons that show up everywhere
    use { 'nvim-tree/nvim-web-devicons' }

    -- telescope and telescope accessories
    use {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.1',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    use {
        "nvim-telescope/telescope-file-browser.nvim",
        requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    }

    -- themes
    use { 'Mofiqul/dracula.nvim', as = 'dracula' }
    use { "catppuccin/nvim", as = "catppuccin" }
    use { "rebelot/kanagawa.nvim", as = "kanagawa" }
    use { "EdenEast/nightfox.nvim", as = "nightfox" }
    use { "savq/melange-nvim", as = "melange" }

    -- syntax highlighting
    use { 'nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' } }
    use { 'nvim-treesitter/nvim-treesitter-context' }

    -- show me my undo history
    use { 'mbbill/undotree' }

    -- git
    use { 'tpope/vim-fugitive' }
    use { 'f-person/git-blame.nvim' }

    -- lsps
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },             -- Required
            { 'williamboman/mason.nvim' },           -- Optional
            { 'williamboman/mason-lspconfig.nvim' }, -- Optional

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },         -- Required
            { 'hrsh7th/cmp-nvim-lsp' },     -- Required
            { 'hrsh7th/cmp-buffer' },       -- Optional
            { 'hrsh7th/cmp-path' },         -- Optional
            { 'saadparwaiz1/cmp_luasnip' }, -- Optional
            { 'hrsh7th/cmp-nvim-lua' },     -- Optional

            -- Snippets
            { 'L3MON4D3/LuaSnip' },             -- Required
            { 'rafamadriz/friendly-snippets' }, -- Optional
        }
    }

    -- for mah formatters that aren't supported
    use { 'jose-elias-alvarez/null-ls.nvim' }

    -- visual help with tabs and spaces
    use('Yggdroot/indentLine')

    -- statusline plugin
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- that sweet sweet surround plugin
    use {
        'tpope/vim-surround',
        config = function()
            vim.g.surround_115 = "**\r**"  -- 115 is the ASCII code for 's'
            vim.g.surround_47 = "/* \r */" -- 47 is /
        end
    }

    -- that sweet sweet commenting help
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    -- that sweet sweet autopair
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    -- entering in the ART ZONE
    use {
        "goolord/alpha-nvim",
        requires = { 'nvim-tree/nvim-web-devicons' }
    }

    -- session management
    use {
        "Shatur/neovim-session-manager",
        requires = { 'nvim-lua/plenary.nvim' },
        config = function() require("session_manager").setup {} end
    }

    -- gimme dat debugger
    use { "mfussenegger/nvim-dap" }
    use { "mfussenegger/nvim-dap-python", requires = { "mfussenegger/nvim-dap" } }
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } }

    use { "tpope/vim-repeat" }

    -- taking a beeg leap here
    use {
        "ggandor/leap.nvim",
        -- one two three repeater!
        requires = { "tpope/vim-repeat" },
        config = function()
            require("leap").add_default_mappings()
        end
    }
end)
