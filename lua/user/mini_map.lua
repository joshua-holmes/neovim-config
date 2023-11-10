local status_ok, mini_map = pcall(require, "mini.map")
if not status_ok then
    print("Failed to load mini_map")
    return
end

mini_map.setup(
    {
        -- Highlight integrations (none by default)
        ---- integrations = nil,
        integrations = {
            mini_map.gen_integration.builtin_search(),
            mini_map.gen_integration.gitsigns(),
            mini_map.gen_integration.diagnostic(),
        },
        -- Symbols used to display data
        symbols = {
            -- Encode symbols. See `:h MiniMap.config` for specification and
            -- `:h MiniMap.gen_encode_symbols` for pre-built ones.
            -- Default: solid blocks with 3x2 resolution.
            encode = nil,

            -- Scrollbar parts for view and line. Use empty string to disable any.
            scroll_line = '█',
            scroll_view = '┃',
        },

        -- Window options
        window = {
            -- Whether window is focusable in normal way (with `wincmd` or mouse)
            focusable = true,

            -- Side to stick ('left' or 'right')
            side = 'right',

            -- Whether to show count of multiple integration highlights
            show_integration_count = true,

            -- Total width
            width = 10,

            -- Value of 'winblend' option
            winblend = 25,

            -- Z-index
            zindex = 10,
        },
    }
)

mini_map.open()
