-- Install Lazy.nvim automatically if it's not installed(Bootstraping)
-- Hint: string concatenation is done by `..`
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "git@github.com:folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- After installation, run `checkhealth lazy` to see if everything goes right
-- Hints:
--     build: It will be executed when a plugin is installed or updated
--     config: It will be executed when the plugin loads
--     event: Lazy-load on event
--     dependencies: table
--                   A list of plugin names or plugin specs that should be loaded when the plugin loads.
--                   Dependencies are always lazy-loaded unless specified otherwise.
--     ft: Lazy-load on filetype
--     cmd: Lazy-load on command
--     init: Functions are always executed during startup
--     branch: string?
--             Branch of the repository
--     main: string?
--           Specify the main module to use for config() or opts()
--           , in case it can not be determined automatically.
--     keys: string? | string[] | LazyKeysSpec table
--           Lazy-load on key mapping
--     opts: The table will be passed to the require(...).setup(opts)
require("lazy").setup({
    -- LSP manager
    {
        "williamboman/mason.nvim",
        url = "git@github.com:williamboman/mason.nvim.git"
    },
    {
        "williamboman/mason-lspconfig.nvim",
        url = "git@github.com:williamboman/mason-lspconfig.nvim.git"
    },
    {
        "neovim/nvim-lspconfig",
        url = "git@github.com:neovim/nvim-lspconfig.git"

    },
    -- Add hooks to LSP to support Linter && Formatter
    {
        "jay-babu/mason-null-ls.nvim",
        url = "git@github.com:jay-babu/mason-null-ls.nvim.git",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            {
                "williamboman/mason.nvim",
                url = "git@github.com:williamboman/mason.nvim.git",
            }, {
            "nvimtools/none-ls.nvim",
            url = "git@github.com:nvimtools/none-ls.nvim.git",

        }
        },
        config = function()
            -- Note:
            --     the default search path for `require` is ~/.config/nvim/lua
            --     use a `.` as a path seperator
            --     the suffix `.lua` is not needed
            require("config.mason-null-ls")
        end,
    },
    -- Vscode-like pictograms
    {
        "onsails/lspkind.nvim",
        url = "git@github.com:onsails/lspkind.nvim.git",

        event = { "VimEnter" },
    },
    -- Auto-completion engine
    {
        "hrsh7th/nvim-cmp",
        url = "git@github.com:hrsh7th/nvim-cmp.git",
        dependencies = {
            {
                "hrsh7th/cmp-cmdline",
                url = "git@github.com:hrsh7th/cmp-cmdline.git",

            },
            {
                "hrsh7th/cmp-nvim-lsp",
                url = "git@github.com:hrsh7th/cmp-nvim-lsp.git",

            },
            {
                "hrsh7th/cmp-buffer",
                url = "git@github.com:hrsh7th/cmp-buffer.git",

            },
            {
                "hrsh7th/cmp-path",
                url = "git@github.com:hrsh7th/cmp-path.git",

            },
        },
        config = function()
            require("config.nvim-cmp")
        end,
    },
    -- Code snippet engine
    {
        "L3MON4D3/LuaSnip",
        url = "git@github.com:L3MON4D3/LuaSnip.git",
        version = "v2.*",
    },
    -- Colorscheme
    -- "tanvirtin/monokai.nvim",
    {
        "EdenEast/nightfox.nvim",
        url = "git@github.com:EdenEast/nightfox.nvim.git",
    },
    -- Better UI
    -- Run `:checkhealth noice` to check for common issues
    {
        "folke/noice.nvim",
        url = "git@github.com:folke/noice.nvim.git",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            {
                "MunifTanjim/nui.nvim",
                url = "git@github.com:MunifTanjim/nui.nvim.git",
            },
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            {
                "rcarriga/nvim-notify",
                url = "git@github.com:rcarriga/nvim-notify.git",
            }
        },
    },
    -- Git integration
    {
        "tpope/vim-fugitive",
        url = "git@github.com:tpope/vim-fugitive.git",
    },
    -- Git decorations
    {
        "lewis6991/gitsigns.nvim",
        url = "git@github.com:lewis6991/gitsigns.nvim.git",
        config = function()
            require("config.gitsigns")
        end,
    },
    -- Autopairs: [], (), "", '', etc
    {
        "windwp/nvim-autopairs",
        url = "git@github.com:windwp/nvim-autopairs.git",
        event = "InsertEnter",
        config = function()
            require("config.nvim-autopairs")
        end,
    },
    -- Treesitter-integration
    {
        "nvim-treesitter/nvim-treesitter",
        url = "git@github.com:nvim-treesitter/nvim-treesitter.git",
        build = ":TSUpdate",
        config = function()
            require("config.nvim-treesitter")
        end,
    },
    -- Nvim-treesitter text objects
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        url = "git@github.com:nvim-treesitter/nvim-treesitter-textobjects.git",
        dependencies = { "nvim-treesitter/nvim-treesitter", url = "git@github.com:nvim-treesitter/nvim-treesitter.git", },
        config = function()
            require("config.nvim-treesitter-textobjects")
        end,
    },
    -- Show indentation and blankline
    {
        "lukas-reineke/indent-blankline.nvim",
        url = "git@github.com:lukas-reineke/indent-blankline.nvim.git",
        main = "ibl",
        config = function()
            require("config.indent-blankline")
        end,
    },
    -- Status line
    {
        "nvim-lualine/lualine.nvim",
        url = "git@github.com:nvim-lualine/lualine.nvim.git",
        dependencies = { "nvim-tree/nvim-web-devicons", url = "git@github.com:nvim-tree/nvim-web-devicons.git",},
        config = function()
            require("config.lualine")
        end,
    },
    -- Markdown support
    { "preservim/vim-markdown", url = "git@github.com:preservim/vim-markdown.git", ft = { "markdown" } },
    -- Markdown previewer
    {
        "iamcco/markdown-preview.nvim",
        url = "git@github.com:iamcco/markdown-preview.nvim.git",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    -- File explorer
    {
        "nvim-tree/nvim-tree.lua",
        url = "git@github.com:nvim-tree/nvim-tree.lua.git",
        dependencies = {
            {
                "nvim-tree/nvim-web-devicons", -- optional, for file icons
                url = "git@github.com:nvim-tree/nvim-web-devicons.git",
               
            }
        },
        config = function()
            require("config.nvim-tree")
        end,
    },
    -- Smart motion
    -- Usage: Enter 2-character search pattern then press a label character to
    --        pick your target.
    --        Initiate the sesarch with `s`(forward) or `S`(backward)
    {
        "ggandor/leap.nvim",
        url = "git@github.com:ggandor/leap.nvim.git",
        config = function()
            -- See `:h leap-custom-mappings` for more details
            require("leap").create_default_mappings()
        end,
    },
    -- Make surrounding easier
    -- ------------------------------------------------------------------
    -- Old text                    Command         New text
    -- ------------------------------------------------------------------
    -- surr*ound_words             gziw)           (surround_words)
    -- *make strings               gz$"            "make strings"
    -- [delete ar*ound me!]        gzd]            delete around me!
    -- remove <b>HTML t*ags</b>    gzdt            remove HTML tags
    -- 'change quot*es'            gzc'"           "change quotes"
    -- delete(functi*on calls)     gzcf            function calls
    -- ------------------------------------------------------------------
    {
        "kylechui/nvim-surround",
        url = "git@github.com:kylechui/nvim-surround.git",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        -- You can use the VeryLazy event for things that can
        -- load later and are not important for the initial UI
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- To solve the conflicts with leap.nvim
                -- See: https://github.com/ggandor/leap.nvim/discussions/59
                keymaps = {
                    insert = "<C-g>z",
                    insert_line = "gC-ggZ",
                    normal = "gz",
                    normal_cur = "gZ",
                    normal_line = "gzgz",
                    normal_cur_line = "gZgZ",
                    visual = "gz",
                    visual_line = "gZ",
                    delete = "gzd",
                    change = "gzc",
                },
            })
        end,
    },
    -- Better terminal integration
    {
        "akinsho/toggleterm.nvim",
        url = "git@github.com:akinsho/toggleterm.nvim.git",
        version = "*",
        config = function()
            require("config.toggleterm")
        end,
    },
    -- Fuzzy finder
    {
        "nvim-telescope/telescope.nvim",
        url = "git@github.com:nvim-telescope/telescope.nvim.git",
        branch = "0.1.x",
        dependencies = { { "nvim-lua/plenary.nvim", url = "git@github.com:nvim-lua/plenary.nvim.git", } },
        config = function()
            require("config.telescope")
        end,
    },
    {
        "folke/trouble.nvim",
        url = "git@github.com:folke/trouble.nvim.git",
        branch = "dev",
        dependencies = { "nvim-tree/nvim-web-devicons", url = "git@github.com:nvim-tree/nvim-web-devicons.git", },
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                desc = "Diagnostics (Trouble)",
            },
            {
                "<leader>xX",
                "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
                desc = "Buffer Diagnostics (Trouble)",
            },
            {
                "<leader>cs",
                "<cmd>Trouble symbols toggle focus=false<cr>",
                desc = "Symbols (Trouble)",
            },
            {
                "<leader>cl",
                "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
                desc = "LSP Definitions / references / ... (Trouble)",
            },
            {
                "<leader>xL",
                "<cmd>Trouble loclist toggle<cr>",
                desc = "Location List (Trouble)",
            },
            {
                "<leader>xQ",
                "<cmd>Trouble qflist toggle<cr>",
                desc = "Quickfix List (Trouble)",
            },
        },
        opts = function()
            require("config.trouble")
        end,
    },
    {
        'rescript-lang/vim-rescript',
        ft = "rescript",
        url = "git@github.com:rescript-lang/vim-rescript.git"
    },
    {
        "folke/which-key.nvim",
        url = "git@github.com:folke/which-key.nvim.git",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        }
    },
    {
        'akinsho/bufferline.nvim',
        url = "git@github.com:akinsho/bufferline.nvim.git",
        event = { 'BufNewFile', 'BufRead', 'TabEnter' },
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            url="git@github.com:nvim-tree/nvim-web-devicons.git",
        },
        config = function()
            require('config.bufferline')
        end,

    },
    -- rust analyzer tool
    {
        'mrcjkb/rustaceanvim',
        url = "git@github.com:mrcjkb/rustaceanvim.git",
        version = '^4', -- Recommended
        lazy = false,   -- This plugin is already lazy
    },
})

require("config.autosave")
require("config.rustaceanvim")
