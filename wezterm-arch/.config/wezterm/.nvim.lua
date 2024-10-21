if vim.uv.os_uname().sysname == "Linux" then
    vim.notify("Linux os. Automirror to /mnt/c/user/ will be skipped.")
end
-- -- Copy config to windows's alacritty dir
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "*.lua" },
    callback = function()
        vim.cmd("silent !bash wezterm.sh ';' display 'Config copied'")
    end,
})

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
