return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
        },
        config = function()
            require("nvim-dap-virtual-text").setup()
            local dap, dapui = require("dap"), require("dapui")

            dapui.setup({
                layouts = { {
                    elements = { {
                        id = "breakpoints",
                        size = 0.25
                    }, {
                        id = "scopes",
                        size = 0.50
                    }, {
                        id = "watches",
                        size = 0.25
                    } },
                    position = "left",
                    size = 50
                }, {
                    elements = { {
                        id = "repl",
                        size = 1.0
                    } },
                    position = "bottom",
                    size = 15
                } },
            })

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            dap.adapters.gdb = {
                type = "executable",
                command = "gdb",
                args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
            }

            dap.configurations.c = {
                {
                    name = "Launch",
                    type = "gdb",
                    request = "launch",
                    program = function()
                        print(vim.fn.system("which gdb"))
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopAtBeginningOfMainSubprogram = false,
                },
            }

            dap.configurations.cpp = dap.configurations.c

            dap.configurations.rust = { {
                name = "Launch",
                type = "gdb",
                request = "launch",
                program = function()
                    vim.fn.system("cargo build --debug")
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopAtBeginningOfMainSubprogram = false,
            } }
        end
    },
}
