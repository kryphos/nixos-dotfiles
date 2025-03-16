return {
    {
        "ej-shafran/compile-mode.nvim",
        branch = "latest",
        dependencies = {
            { "m00qek/baleia.nvim", tag = "v1.3.0" },
        },
        config = function()
            vim.g.compile_mode = {
                baleia_setup = true,
            }
        end
    },

    {
        "nvim-pack/nvim-spectre",
        config = function()
            require('spectre').setup()
        end
    },

    {
        "robitx/gp.nvim",
        config = function()
            require("gp").setup({
                chat_confirm_delete = false,
                providers = {
                    googleai = {
                        endpoint =
                        "https://generativelanguage.googleapis.com/v1/models/{{model}}:streamGenerateContent?key={{secret}}",
                        secret = vim.fn.readfile("/home/luca/.secrets/googleapi")[1],
                    },
                },
                agents = {
                    {
                        name = "Gemini",
                        disable = false,
                        provider = "googleai",
                        chat = true,
                        command = false,
                        model = { model = "gemini-2.0-flash" },
                    },
                    {
                        name = "ChatGPT3-5",
                        disable = true,
                    },
                    {
                        name = "ChatGPT4o",
                        disable = true,
                    },
                    {
                        name = "ChatGPT4o-mini",
                        disable = true,
                    },
                    {
                        name = "ChatGemini",
                        disable = true,
                    },
                },
            })
        end,
    },
}
