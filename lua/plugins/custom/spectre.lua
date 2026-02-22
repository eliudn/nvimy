-- lua/plugins/extras/spectre.lua
if true then
    return {}
end
return {
    "nvim-pack/nvim-spectre",
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    keys = {
        { "<leader>sr", function() require("spectre").open() end,             desc = "Replace in files (Spectre)" },
        { "<leader>sf", function() require("spectre").open_file_search() end, desc = "Replace in current file" },
    },
}
