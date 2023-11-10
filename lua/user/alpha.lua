local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
    print("Failed to load alpha")
    return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
    [[                               __                ]],
    [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
    [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
    [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
    [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
    [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
}
dashboard.section.buttons.val = {
    dashboard.button("f", "  Find file", ":Telescope find_files <CR>"),
    dashboard.button("F", "󱎸  Find text", ":Telescope live_grep theme=ivy <CR>"),
    dashboard.button("p", "  Find project", ":Telescope projects <CR>"),
    dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("r", "  Recently used files", ":Telescope oldfiles <CR>"),
    dashboard.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
    dashboard.button("q", "  Quit Neovim", ":qa<CR>"),
}

local function footer()
    -- NOTE: requires the fortune-mod package to work
    local handle = io.popen("fortune")
    local fortune = "jpholmes.com" -- default if fortune-mod doesn't owrk
    if handle then
        fortune = handle:read("*a")
        handle:close()
    end
    return fortune
end

dashboard.section.footer.val = footer()

dashboard.section.footer.opts.hl = "Type"
dashboard.section.header.opts.hl = "Include"
dashboard.section.buttons.opts.hl = "Keyword"

dashboard.opts.opts.noautocmd = true
alpha.setup(dashboard.opts)
