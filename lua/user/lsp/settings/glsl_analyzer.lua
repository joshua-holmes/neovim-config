local filetypes = { "glsl", "vert", "tesc", "tese", "frag", "geom", "comp" }

for _, ft in ipairs(filetypes) do
    -- https://neovim.io/doc/user/lua.html#vim.filetype
    vim.filetype.add({
        pattern = {
            -- pattern must end with .<ft> where <ft> is one of the filetypes above
            ["(.+)(%." .. ft .. ")"] = "glsl",
        },
    })
end

return {
    filetypes = filetypes,
    single_file_support = true,
    capabilities = {},
}
