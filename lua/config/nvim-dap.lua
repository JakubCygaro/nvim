local dap = require'dap'
local get_data_path = function ()
    local data_path = vim.fn.stdpath('data');
    return data_path;
end

local script_etx = ''

if jit.os == 'Windows' then
    script_etx = '.cmd'
end

dap.adapters.lldb = {
  type = 'executable',
  command = get_data_path() .. '/mason/bin/codelldb' .. script_etx, -- adjust as needed, must be absolute path
  name = 'lldb'
}
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  name = 'cppdbg',
  command = get_data_path() .. '/mason/bin/OpenDebugAD7' .. script_etx, -- adjust as needed, must be absolute path
  options = {
      detached = false,
  },
}
dap.configurations.rust = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
    args = {},
  },
}
dap.configurations.cpp = {
    {
        name = 'Launch',
        type = 'cppdbg',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        -- stopOnEntry = true,
        -- runInTerminal = true,
        -- externalConsole = false,
    }
}
dap.configurations.p = {
    {
        name = 'Launch',
        type = 'cppdbg',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        -- stopOnEntry = true,
        -- runInTerminal = true,
        -- externalConsole = false,
    }
}
