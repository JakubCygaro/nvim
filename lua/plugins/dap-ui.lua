return {
    "rcarriga/nvim-dap-ui",
    dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
    opts = {
        layouts = {
          {
             elements = {
               { id = "console", size = 0.5 },
               { id = "repl", size = 0.5 },
             },
             position = "right",
             size = 50,
          },
          {
            elements = {
              { id = "scopes", size = 0.50 },
              { id = "breakpoints", size = 0.20 },
              { id = "stacks", size = 0.15 },
              { id = "watches", size = 0.15 },
            },
            position = "bottom",
            size = 15,
          },
        },
    }
}
