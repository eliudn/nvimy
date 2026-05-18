if not vim.env.KITTY_WINDOW_ID then return end

-- fuentes para kitty
local function kitty_load(config)
  local socket = vim.env.KITTY_LISTEN_ON
  local to = socket and socket ~= "" and (" --to " .. socket) or ""
  vim.fn.system("kitty @" .. to .. " load-config " .. config)
end

local group = vim.api.nvim_create_augroup("KittyFont", { clear = true })

vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  group = group,
  callback = function()
    kitty_load(vim.fn.expand("~/.config/kitty/kitty-nvim.conf"))
  end,
})

vim.api.nvim_create_autocmd("VimLeave", {
  once = true,
  group = group,
  callback = function()
    kitty_load(vim.fn.expand("~/.config/kitty/kitty.conf"))
  end,
})
