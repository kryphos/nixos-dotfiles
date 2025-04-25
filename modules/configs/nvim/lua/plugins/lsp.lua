local installed = {
    "bash-language-server",
    "bibtex-tidy",
    "black",
    "css-lsp",
    "cssmodules-language-server",
    "docker_compose_language_service",
    "dockerfile-language-server",
    "emmet_language_server",
    "eslint-lsp",
    "glsl_analyzer",
    "glslls",
    "gopls",
    "hlint",
    "html-lsp",
    "isort",
    "json-lsp",
    "latexindent",
    "lua-language-server",
    "nil",
    "nixpkgs-fmt",
    "prettierd",
    "pyright",
    "rust_analyzer",
    "sqlls",
    "tailwindcss-language-server",
    "taplo",
    "terraform-ls",
    "texlab",
    "tree-sitter-cli",
    "typescript-language-server",
    "typos_lsp",
    "vim-language-server",
    "yaml-language-server",
    "zls",
}

return {
    {
        "williamboman/mason.nvim",
        dependencies = {
            { "nvimtools/none-ls.nvim" },
            { "jay-babu/mason-null-ls.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "neovim/nvim-lspconfig" },
            { "lervag/vimtex" },
            {
                "saecki/crates.nvim",
                config = function()
                    require("crates").setup({})
                end
            },
            {
                "lvimuser/lsp-inlayhints.nvim",
                config = function()
                    vim.diagnostic.config({
                        virtual_text = true
                    })

                    require("lsp-inlayhints").setup()
                end
            },
            {
                "folke/lazydev.nvim",
                ft = "lua",
                opts = {
                    library = {
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
            {
                "dmmulroy/ts-error-translator.nvim",
                config = function()
                    require("ts-error-translator").setup()
                end
            },
            {
                "ivanjermakov/troublesum.nvim",
                config = function()
                    require("troublesum").setup()
                end
            }
        },
        config = function()
            require("mason").setup()
            require("null-ls").setup()
            require("mason-null-ls").setup({
                ensure_installed = installed,
                handlers = {},
                automatic_installation = true,
            })

            require("mason-lspconfig").setup()
            require("mason-lspconfig").setup_handlers {
                function(server_name)
                    require("lspconfig")[server_name].setup {}
                end,
            }

            -- dont use the clangd from mason cuz it cant find system headers on nixos
            require("lspconfig").clangd.setup({
                cmd = {
                    "clangd",
                    "--offset-encoding=utf-16",
                    "--background-index",
                    "--suggest-missing-includes",
                },
            })
        end,
    },

    {
        'stevearc/conform.nvim',
        config = function()
            require("conform").setup({
                formatters_by_ft = {
                    bib = { "bibtex-tidy" },
                    css = { "prettier" },
                    html = { "prettier" },
                    javascript = { "prettier" },
                    latex = { "latexindent" },
                    python = { "isort", "prettier" },
                    scss = { "prettier" },
                },
                format_on_save = {
                    timeout_ms = 500,
                    lsp_format = "fallback",
                },
            })
        end,
    }
}
