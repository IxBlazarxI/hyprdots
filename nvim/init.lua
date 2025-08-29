require("custom_color").setup()
vim.cmd [[
  hi StatusLine guibg=NONE ctermbg=NONE
  hi StatusLineNC guibg=NONE ctermbg=NONE
]]

vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = true
vim.opt.scrolloff = 10
vim.opt.sidescrolloff = 8

-- Indentation
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true

-- Search settings
vim.opt.hlsearch = false
 
-- Visual settings
vim.opt.termguicolors = true
vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = "#005071" })
vim.opt.signcolumn = "yes"
vim.opt.showmatch = true
vim.opt.guicursor = "a:block"
vim.opt.matchtime = 2
vim.opt.cmdheight = 1
vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.showmode = false
vim.opt.pumheight = 10
vim.opt.pumblend = 10
vim.opt.winblend = 0
vim.opt.conceallevel = 0
vim.opt.concealcursor = ""
vim.opt.lazyredraw = true
vim.opt.synmaxcol = 300
vim.opt.statusline = "%f %y %m %r %= %l:%c %p%%"
vim.g.nvimtree_side = "right"

-- File handling
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.vim/undodir")
vim.opt.updatetime = 300
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 0
vim.opt.autoread = true
vim.opt.autowrite = false

-- Behavior settings
vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.backspace = "indent,eol,start"
vim.opt.autochdir = false
vim.opt.iskeyword:append("-")
vim.opt.path:append("**")
vim.opt.selection = "exclusive"
vim.opt.mouse = "a"
vim.opt.clipboard:append("unnamedplus")
vim.opt.modifiable = true
vim.opt.encoding = "UTF-8"

vim.keymap.set("n", "Y", "y$", { desc = "Yank to the end of line" })

-- Keybinds
vim.g.mapleader = " "
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("i", "kj", "<Esc>")
vim.keymap.set("n", "dw", "daw")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "<C-f>", ":NvimTreeToggle<CR>")
vim.g.codeium_no_map_tab = 1  
vim.keymap.set("i", "<C-j>", function()
    return vim.fn["codeium#Accept"]()
end, { expr = true, noremap = true, desc = "Accept Codeium suggestion" })


-- Split window
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>")
vim.keymap.set("n", "<leader>sh", "split<CR>")

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Explorer
vim.keymap.set("n", "<leader>e", ":Explore<CR>")
vim.keymap.set("n", "<leader>ff", ":find ")

-- Misc
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup,
    callback = function()
        vim.hl.on_yank()
    end,
})

vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"

local function git_branch()
    local branch = vim.fn.system("git branch --show-current 2>/dev/null | tr -d '\n'")
    if branch ~= "" then
        return "  " .. branch .. " "
    end
    return ""
end

local function file_type()
    local ft = vim.bo.filetype
    local icons = {
        lua = "[LUA]", 
        python = "[PY]", 
        javascript = "[JS]", 
        c = "[C]", 
        html = "[HTML]", 
        css = "[CSS]", 
        json = "[JSON]",
        markdown = "[MD]", 
        vim = "[VIM]",
        sh = "[SH]", 
    }

    if ft == "" then
        return "  "
    end

    return (icons[ft] or ft)
end

-- Plugins let's gooooo
require("nvim-autopairs").setup{}
require("nvim-tree").setup{}
require("nvim-treesitter.configs").setup{
    ensure_installed = {"lua", "python", "javascript", "c", "cpp", "go", "json", "html", "css"},
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
    },
}

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup
require("lazy").setup({
    -- Autopairs
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup{}
        end,
    },

    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate", 
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "pyright",
                    "clangd",
                    "gopls",
                    "jsonls",
                    "html",
                    "cssls",
                    "ts_ls", 
                    "lua_ls",
                },
            })
        end,
    },

    -- LSP Config
    {
        "neovim/nvim-lspconfig",
        dependencies = { "mason-lspconfig.nvim" },
        config = function()
            local lspconfig = require("lspconfig")
            local servers = require("mason-lspconfig").get_installed_servers()

            for _, server_name in ipairs(servers) do
                lspconfig[server_name].setup({})
            end
        end,
    },

    -- Nvim-tree
     {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("nvim-tree").setup({
                view = {
                    side = "right",
                },
                renderer = {
                    icons = {
                        show = {
                            file = true,
                            folder = true,
                            folder_arrow = true,
                        },
                    },
                },
            })
        end,
    },

    -- Codeium
    {
        "Exafunction/codeium.vim",
        config = function()
            vim.g.codeium_no_map_tab = 1
        end,
    },

    -- Color picker
    {
        "ziontee113/color-picker.nvim",
        config = function()
            require("color-picker").setup{}
        end,
    },

    -- Discord RPC
    {
        "andweeb/presence.nvim",
        config = function()
            require("presence").setup{}
        end,
    },

    -- Lualine
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("lualine").setup({
                options = {
                    theme = require('mylualine').theme(),
                },
            })
        end,
    },

    -- Highlight Colors
    {
        "brenoprata10/nvim-highlight-colors",
        config = function()
            require("nvim-highlight-colors").setup{}
        end,
    },

    -- nvim-cmp
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", 
            "hrsh7th/cmp-buffer",
            "L3MON4D3/LuaSnip",     
            "saadparwaiz1/cmp_luasnip", 
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),

                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),

                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                }),
            })
        end,
    },
    {
      'ada0l/obsidian',
      lazy = 'VeryLazy',
      keys = {
        { '<leader>ov', '<cmd>lua require("obsidian").vault_prompt()<cr>', desc = 'Vault prompt' },
        { '<leader>oc', '<cmd>lua require("obsidian").cd_vault()<cr>', desc = 'Cd vault' },
        { '<leader>on', '<cmd>lua require("obsidian").new_note_prompt()<cr>', desc = 'New note' },
        { '<leader>ot', '<cmd>lua require("obsidian").open_today()<cr>', desc = 'Open today' },
        { '<leader>oT', '<cmd>lua require("obsidian").open_today_prompt()<cr>', desc = 'Open today (shift)' },
        { '<leader>oi', '<cmd>lua require("obsidian").template_picker()<cr>', desc = 'Template picker' },
        { '<leader>of', '<cmd>lua require("obsidian").note_picker()<cr>', desc = 'Note picker' },
        { '<leader>ob', '<cmd>lua require("obsidian").backlinks_picker()<cr>', desc = 'Backlinks picker' },
        { '<leader>or', '<cmd>lua require("obsidian").rename_prompt()<cr>', desc = 'Rename prompt' },
        {
          'gf',
          function()
            if require('obsidian').found_wikilink_under_cursor() ~= nil then
              return '<cmd>lua require("obsidian").go_to()<CR>'
            else
              return 'gf'
            end
          end,
          noremap = false,
          expr = true,
        },
      },
      ---@type ObsidianOptions
      opts = {
        extra_fd_opts = '--exclude assets --exclude journals --exclude _debug_remotely_save',
        vaults = {
          {
            dir = '~/Knowledge/',
            daily = {
              dir = 'journals',
              format = '%Y-%m-%d',
            },
            note = {
              dir = '.',
              transformator = function(filename)
                if filename ~= nil and filename ~= '' then
                  return filename
                end
                return string.format('%d', os.time())
              end,
            },
            templates = {
              dir = 'templates',
              date = '%Y-%d-%m',
              time = '%Y-%d-%m',
            },
          },
        },
      },
    },

    --- CCC 
    {
      "uga-rosa/ccc.nvim",
      cmd = "CccPick",  
      keys = {
        { "<leader>c", "<cmd>CccPick<CR>", desc = "Open Color Picker" },
      },
      config = function()
        require("ccc").setup({
          highlighter = {
            auto_enable = true,
          },
        })
      end,
    },
    {
      "vhyrro/luarocks.nvim",
      priority = 1001,         
      opts = { rocks = { "magick" } },  
    },

    {
      "3rd/image.nvim",
      dependencies = { "vhyrro/luarocks.nvim" },
      config = function()
        require("image").setup({
          backend = "kitty",  
        })
      end,
    },
})

-- i don't even use this
vim.diagnostic.config({
    virtual_text = true,  
    signs = true,         
    update_in_insert = false, 
})

-- Keymaps for navigating diagnostics
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Set diagnostics in location list" })
