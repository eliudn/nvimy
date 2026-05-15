-- require("autocomands.easy_close_buffers")
-- require("autocomands.notify_formatter")
-- require("autocomands.remove_trailing_whitespace")
-- require("autocomands.highlight_yank")
-- require("autocomands.restore_cursor")
-- require("autocomands.latex")
local features = require("autocomands.features")

for autocomand, enabled in pairs(features.autocomands) do
    if enabled then
        local name = "autocomands." .. autocomand
        require(name)
    end
end
