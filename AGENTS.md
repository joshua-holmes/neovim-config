# AGENTS.md - Neovim Configuration Guidelines

## Overview

Personal Neovim configuration using lazy.nvim as plugin manager. Files in `lua/user/` directory.

## Directory Structure

```
nvim/
├── init.lua                 -- Main entry point
├── lua/user/
│   ├── plugins.lua          -- lazy.nvim configuration
│   ├── options.lua          -- vim.opt settings
│   ├── keymaps.lua          -- Key mappings
│   ├── colorscheme.lua      -- Color scheme
│   ├── cmp.lua              -- nvim-cmp completion
│   ├── telescope.lua        -- Telescope picker
│   ├── gitsigns.lua         -- Git integration
│   ├── treesitter.lua       -- Treesitter
│   ├── autopairs.lua        -- Auto pairs
│   ├── nvim-tree.lua        -- File tree
│   ├── bufferline.lua       -- Buffer tabs
│   ├── lualine.lua          -- Status line
│   ├── whichkey.lua         -- Which-key hints
│   ├── dapui.lua            -- DAP UI
│   ├── lsp/                 -- LSP config (init, handlers, mason, null-ls)
│   └── dap/                 -- DAP config (init, adapters, configurations)
```

## Build/Lint/Test Commands

### Testing Configuration
```bash
# Check for syntax errors
nvim --headless -c "lua vim.cmd('quitall')" 2>&1

# Or from within Neovim
:checkhealth

# Lua syntax check
:luacheck lua/
```

### Plugin Management
```bash
# After modifying plugins.lua, run inside Neovim:
:Lazy sync    # Install, update and clean plugins
:Lazy install # Install missing plugins
:Lazy update  # Update plugins
:Lazy clean   # Remove unused plugins
:Lazy         # Open lazy.nvim UI
```

## Code Style Guidelines

### General Conventions
1. **Module Pattern**: Each feature in its own file under `lua/user/`
2. **Protected Calls**: Always use `pcall` for requires:
   ```lua
   local status_ok, module = pcall(require, "module_name")
   if not status_ok then
       print("Failed to load module_name")
       return
   end
   ```
3. **Local Functions**: Use local to avoid polluting global namespace

### Naming Conventions
- **Files**: Snake case (`lua/user/lsp/handlers.lua`)
- **Variables**: Lowercase with underscores (`local my_variable = 1`)
- **Constants**: Uppercase (`local CONSTANT_VALUE = 100`)
- **Functions**: Lowercase with underscores (`local function my_function()`)
- **Tables/Modules**: Pascal case for module return (`local M = {}`)

### Imports and Requires
```lua
local status_ok, module = pcall(require, "module_name")
if not status_ok then
    return
end

-- Use aliases for long paths
local cmp = require("cmp")
```

### Formatting
- **Indentation**: 4 spaces
- **Line Length**: Soft limit at 100 characters
- **Trailing Commas**: Allowed in Lua tables
- **Trailing Whitespace**: Avoid

### Keymap Conventions
```lua
local opts = { noremap = true, silent = true }
local keymap = vim.keymap.set
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
```

### Options Pattern
```lua
local options = {
    backup = false,
    clipboard = "unnamedplus",
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- Modify existing
vim.opt.shortmess:append("c")
```

### Error Handling
- Always wrap `require` in `pcall`
- Print meaningful errors but don't block Neovim from loading
- Return early if critical module fails

### Example Module Structure
```lua
local M = {}

local status_ok, dep = pcall(require, "dependency")
if not status_ok then
    print("Failed to load dependency")
    return
end

M.setup = function()
    -- Configuration
end

return M
```

## Common Tasks

### Adding a New Plugin
1. Add to `lua/user/plugins.lua` using lazy.nvim syntax
2. Create config file in `lua/user/`
3. Add `require("user.plugin_name")` to `init.lua`
4. Run `:Lazy sync`

### Adding LSP Server
1. Add to Mason in `lua/user/lsp/mason.lua`
2. Create settings in `lua/user/lsp/settings/` if needed

## Notes for Agents
- Personal Neovim config - avoid changes unless requested
- Uses lazy.nvim for plugin management
- Some plugins require external deps (ripgrep, fd, node/npm)
- Respect existing keybindings and workflow patterns
