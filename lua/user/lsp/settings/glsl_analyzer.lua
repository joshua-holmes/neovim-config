local filetypes = { "glsl", "vert", "tesc", "tese", "frag", "geom", "comp" }

for _, ft in ipairs(filetypes) do
    vim.filetype.add({
        pattern = {
            ["(.+)(%." .. ft ..")"] = "glsl"
        }
    })
end

return {
	filetypes = filetypes,
	single_file_support = true,
	capabilities = {},
}
