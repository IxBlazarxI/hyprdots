local M = {}
M.theme = function()
    local colors = {
        darkgray = "#e82315",
        gray = "#ba1e02",
        normal = "#7e9cd8",
        insert = "#98bb6c",
        visual = "#ffa066",
        replace = "#e46876",
        command = "#e6c384",
    }
    return {
        inactive = {
            a = { fg = colors.gray, bg = "none", gui = "bold" },
            b = { fg = colors.gray, bg = "none" },
            c = { fg = colors.gray, bg = "none" },
        },
        visual = {
            a = { fg = colors.darkgray, bg = "none", gui = "bold" },
            b = { fg = colors.gray, bg = "none" },
            c = { fg = colors.gray, bg = "none" },
        },
        replace = {
            a = { fg = colors.darkgray, bg = "none", gui = "bold" },
            b = { fg = colors.gray, bg = "none" },
            c = { fg = colors.gray, bg = "none" },
        },
        normal = {
            a = { fg = colors.darkgray, bg = "none", gui = "bold" },
            b = { fg = colors.gray, bg = "none" },
            c = { fg = colors.gray, bg = "none" },
        },
        insert = {
            a = { fg = colors.darkgray, bg = "none", gui = "bold" },
            b = { fg = colors.gray, bg = "none" },
            c = { fg = colors.gray, bg = "none" },
        },
        command = {
            a = { fg = colors.darkgray, bg = "none", gui = "bold" },
            b = { fg = colors.gray, bg = "none" },
            c = { fg = colors.gray, bg = "none" },
        },
    }
end
return M
