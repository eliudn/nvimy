if not vim.env.KITTY_WINDOW_ID then return end

local function kitty_cmd(spacing)
    local socket = vim.env.KITTY_LISTEN_ON
    local to = socket and socket ~= "" and (" --to " .. socket) or ""
    vim.fn.system("kitty @" .. to .. " set-spacing padding=" .. spacing)
end

vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function() kitty_cmd(0) end,
})

vim.api.nvim_create_autocmd("VimLeave", {
    once = true,
    callback = function() kitty_cmd(10) end,
})
