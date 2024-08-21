local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
    print("Failed to load toggleterm")
    return
end

toggleterm.setup({
    size = 20,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = "float",
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
})

local function wrap_cmd(cmd, exit_after_run)
    local end_cmd = "; echo \"\nneovim finished running cmd with code $?:\" && echo '" .. cmd .. "'"
    if not exit_after_run then
        end_cmd = end_cmd .. " && sleep 1d"
    end
    return cmd .. end_cmd
end

function _G.set_terminal_keymaps()
    local opts = { noremap = true }
    vim.api.nvim_buf_set_keymap(0, "t", "<C-end>", [[<C-\><C-n>]], opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
function _LAZYGIT_TOGGLE()
    lazygit:toggle()
end

local node = Terminal:new({ cmd = "node", hidden = true })
function _NODE_TOGGLE()
    node:toggle()
end

local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })
function _NCDU_TOGGLE()
    ncdu:toggle()
end

local htop = Terminal:new({ cmd = "htop", hidden = true })
function _HTOP_TOGGLE()
    htop:toggle()
end

local python = Terminal:new({ cmd = "python", hidden = true })
function _PYTHON_TOGGLE()
    python:toggle()
end

local test_servo = Terminal:new({ hidden = false })
function _TEST_SERVO()
    local cur_buffer_dir = vim.api.nvim_buf_get_name(0)
    test_servo.cmd = wrap_cmd("./mach test-wpt -d -- --pref layout.flexbox.enabled " .. cur_buffer_dir)
    test_servo:toggle()
end

local open_servo = Terminal:new({ hidden = true })
function _OPEN_SERVO()
    local cur_buffer_dir = vim.api.nvim_buf_get_name(0)
    local log_out = "servo.log"
    open_servo.cmd = wrap_cmd("nohup ./mach run -d -- --pref layout.flexbox.enabled " ..
        cur_buffer_dir .. " > " .. log_out .. " 2>&1 & sleep 0.1", true)
    open_servo:toggle()
end

local open_firefox = Terminal:new({ hidden = true })
function _OPEN_FIREFOX()
    local cur_buffer_dir = vim.api.nvim_buf_get_name(0)
    open_firefox.cmd = wrap_cmd("firefox --new-window " .. cur_buffer_dir, true)
    open_firefox:toggle()
end
