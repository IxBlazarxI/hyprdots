local M = {}

M.colors = {
    bg       = "#101030",
    fg       = "#b7b7e7",
    red      = "#da2f48",
    orange   = "#ff2020",
    yellow   = "#ffff00",
    green    = "#1d211f",
    cyan     = "#67b8d8",  
    blue     = "#5a7aa0",  
    purple   = "#8000ff",
    comment  = "#808080",  
}

M.setup = function()
    local c = M.colors

    vim.cmd("hi clear")
    if vim.fn.exists("syntax_on") then
        vim.cmd("syntax reset")
    end
    vim.o.background = "dark"
    vim.o.termguicolors = true

    vim.api.nvim_set_hl(0, "Normal",        { fg = c.fg, bg = c.bg })
    vim.api.nvim_set_hl(0, "CursorLine",    { bg = "#151a24" })
    vim.api.nvim_set_hl(0, "Visual",        { bg = "#567e8c" })
    vim.api.nvim_set_hl(0, "Comment",       { fg = c.comment, italic = true })
    vim.api.nvim_set_hl(0, "Constant",      { fg = c.cyan })
    vim.api.nvim_set_hl(0, "String",        { fg = c.yellow })
    vim.api.nvim_set_hl(0, "Identifier",    { fg = c.blue })
    vim.api.nvim_set_hl(0, "Function",      { fg = c.cyan, bold = true })
    vim.api.nvim_set_hl(0, "Statement",     { fg = c.purple })
    vim.api.nvim_set_hl(0, "Type",          { fg = c.purple })
    vim.api.nvim_set_hl(0, "Keyword",       { fg = c.purple, bold = true })
    vim.api.nvim_set_hl(0, "Operator",      { fg = c.blue })
    vim.api.nvim_set_hl(0, "PreProc",       { fg = c.cyan })
    vim.api.nvim_set_hl(0, "Error",         { fg = c.red, bg = c.bg, bold = true })
    vim.api.nvim_set_hl(0, "WarningMsg",    { fg = c.orange, bold = true })
    vim.api.nvim_set_hl(0, "Search",        { fg = c.bg, bg = c.cyan })
    vim.api.nvim_set_hl(0, "IncSearch",     { fg = c.bg, bg = c.purple })
    vim.api.nvim_set_hl(0, "Pmenu",         { fg = c.fg, bg = "#151a24" })
    vim.api.nvim_set_hl(0, "PmenuSel",      { fg = c.bg, bg = c.cyan, bold = true })
end

return M

