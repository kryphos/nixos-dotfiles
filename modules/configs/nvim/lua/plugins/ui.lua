return {
    { "nvim-tree/nvim-web-devicons" },

    { "xiyaowong/transparent.nvim" },

    {
        "Shatur/neovim-ayu",
        config = function()
            vim.cmd.colorscheme "ayu"
        end
    },

    {
        "sontungexpt/sttusline",
        branch = "table_version",
        config = function()
            require("sttusline").setup({
                statusline_color = "#000000",
                components = {
                    "mode",
                    "filename",
                    "git-branch",
                    "%=",
                    "lsps-formatters",
                    "indent",
                    "encoding",
                    "pos-cursor",
                    "pos-cursor-progress",
                },
            })
        end
    },

    { "romgrk/barbar.nvim" },

    {
        "xiyaowong/virtcolumn.nvim",
        config = function()
            vim.g.virtcolumn_char = "▕"
            vim.g.virtcolumn_priority = 10
        end
    },

    { "RRethy/vim-illuminate" },

    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        dependencies = {
            { "HiPhish/rainbow-delimiters.nvim" },
        },
        config = function()
            local highlight = {
                "RainbowRed",
                "RainbowYellow",
                "RainbowBlue",
                "RainbowOrange",
                "RainbowGreen",
                "RainbowViolet",
                "RainbowCyan",
            }
            local hooks = require "ibl.hooks"
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
                vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
                vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
                vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
                vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
                vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
                vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
            end)

            vim.g.rainbow_delimiters = { highlight = highlight }
            require("ibl").setup { scope = { highlight = highlight } }

            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        end
    },

    {
        "NvChad/nvim-colorizer.lua",
        lazy = true,
        event = "BufRead",
        config = function()
            require("colorizer").setup({
                user_default_options = {
                    mode = "virtualtext",
                    virtualtext_inline = true,
                    tailwind = true,
                    always_update = true,
                },
            })
        end
    },

    {
        "folke/snacks.nvim",
        opts = {
            bigfile = { enabled = true },
            image = { enabled = true },
            input = { enabled = true },
            notifier = { enabled = true },
        },
    },

    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                messages = { enabled = true },
                notify = { enabled = true },
                cmdline = { enabled = true },
            })
        end
    },

    {
        'MeanderingProgrammer/render-markdown.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
        config = function()
            require('render-markdown').enable()
            require('render-markdown').setup({
                completions = { lsp = { enabled = true } },
            })
        end
    }
}
