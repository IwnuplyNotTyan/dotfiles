    local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	{'neovim/nvim-lspconfig',
	config = function()
	local status, nvim_lsp = pcall(require, "lspconfig")
	if not status then
	return
	end

	local on_attach = function(client, bufnr)
	if client.server_capabilities.documentFormattingProvider then
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = vim.api.nvim_create_augroup("Format", { clear = true }),
			buffer = bufnr,
			callback = function()
				vim.lsp.buf.formatting_seq_sync()
			end,
		})
		end
	end

	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	end },
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/cmp-buffer'},
	{'hrsh7th/nvim-cmp',
	config = function()
		local status, cmp = pcall(require, "cmp")
	if (not status) then return end
	local lspkind = require 'lspkind'
	local function formatForTailwindCSS(entry, vim_item)
	  if vim_item.kind == 'Color' and entry.completion_item.documentation then
 	   local _, _, r, g, b = string.find(entry.completion_item.documentation, '^rgb%((%d+), (%d+), (%d+)')
 	   if r then
   	   local color = string.format('%02x', r) .. string.format('%02x', g) .. string.format('%02x', b)
   	   local group = 'Tw_' .. color
      	if vim.fn.hlID(group) < 1 then
        vim.api.nvim_set_hl(0, group, { fg = '#' .. color })
      	end
      	vim_item.kind = "●"
      	vim_item.kind_hl_group = group
      	return vim_item
    	end
  	end
	  vim_item.kind = lspkind.symbolic(vim_item.kind) and lspkind.symbolic(vim_item.kind) or vim_item.kind
 	 return vim_item
	end
	cmp.setup({
	  snippet = {
  	  expand = function(args)
      	require('luasnip').lsp_expand(args.body)
    	end,
  	},
 	 mapping = cmp.mapping.preset.insert({
    	['<C-d>'] = cmp.mapping.scroll_docs(-4),
    	['<C-f>'] = cmp.mapping.scroll_docs(4),
    	['<C-Space>'] = cmp.mapping.complete(),
    	['<C-e>'] = cmp.mapping.close(),
   	 ['<CR>'] = cmp.mapping.confirm({
      	behavior = cmp.ConfirmBehavior.Replace,
      	select = true
    	}),
 	 }),
	  sources = cmp.config.sources({
   	 { name = 'nvim_lsp' },
 	   { name = 'buffer' },
  	}),
 	 formatting = {
    	format = lspkind.cmp_format({
      	maxwidth = 50,
      	before = function(entry, vim_item)
        vim_item = formatForTailwindCSS(entry, vim_item)
        return vim_item
      	end
    	})
  	}
	})
	vim.cmd [[
	  set completeopt=menuone,noinsert,noselect
 	 highlight! default link CmpItemKind CmpItemMenuDefault
	]]
	end },
	{'onsails/lspkind.nvim',
	config = function()
		local status, lspkind = pcall(require, "lspkind")
		if (not status) then return end
		require('lspkind').init({
			   mode = 'symbol_text',
			       preset = 'codicons',
			       symbol_map = {
      		Text = "󰉿",
      		Method = "󰆧",
      		Function = "󰊕",
      		Constructor = "",
      		Field = "󰜢",
      		Variable = "󰀫",
      		Class = "󰠱",
      		Interface = "",
      		Module = "",
      		Property = "󰜢",
      		Unit = "󰑭",
      		Value = "󰎠",
      		Enum = "",
      		Keyword = "󰌋",
      		Snippet = "",
      		Color = "󰏘",
      		File = "󰈙",
     	 	Reference = "󰈇",
     	 	Folder = "󰉋",
     	 	EnumMember = "",
     	 	Constant = "󰏿",
     	 	Struct = "󰙅",
     	 	Event = "",
	      	Operator = "󰆕",
      		TypeParameter = "",
    	}
	})
	end },
	{'norcalli/nvim-colorizer.lua',
		config = function()
			require'colorizer'.setup()
		end},
	{'nvim-treesitter/nvim-treesitter'},
	{'nvim-tree/nvim-tree.lua',
	config = function()
	require("nvim-tree").setup()
	local circles = require('circles')
	circles.setup({ icons = { empty = '', filled = '', lsp_prefix = '' } })
	require('nvim-tree').setup({
	  renderer = {
    	icons = {
      	glyphs = circles.get_nvimtree_glyphs(),
    	},
 	 },
	})
	end },
	{'MunifTanjim/prettier.nvim'},
	{'nvim-lualine/lualine.nvim',
	config = function()
		require('lualine').setup()
		local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end
local spaces = {
	function()
		return " "
	end,
	padding = -1,
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = {
		"error",
		"warn",
		"hint",
	},
	symbols = {
		error = " ",
		warn = " ",
		hint = " ",
		info = " ",
	},
	colored = true,
	always_visible = false,
}

local branch = {
	"branch",
	icon = "󰊢 ",
	separator = { left = "", right = "" },
  padding = 0.1
}

local diff = {
	"diff",
	colored = true,
	symbols = {
		added = " ",
		modified = " ",
		removed = " ",
	},
	separator = { left = "", right = "" },
}

local filetype = {
	"filetype",
	icons_enabled = true,
}

local location = {
	"location",
}

local custom_icons = {
	function()
		return " "
	end,
	separator = { left = "", right = "" },
}

local modes = {
	"mode",
	separator = { left = "", right = "" },
	padding = 0.8,
}

local indent = function()
	return "" .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local lsp_progess = function()
	msg = msg or "LS Inactive"
	local buf_clients = vim.lsp.buf_get_clients()
	if next(buf_clients) == nil then
		if type(msg) == "boolean" or #msg == 0 then
			return "LS Inactive"
		end
		return msg
	end
	local buf_ft = vim.bo.filetype
	local buf_client_names = {}
	local copilot_active = false
	local null_ls = require("null-ls")
	local alternative_methods = {
		null_ls.methods.DIAGNOSTICS,
		null_ls.methods.DIAGNOSTICS_ON_OPEN,
		null_ls.methods.DIAGNOSTICS_ON_SAVE,
	}

	-- add client
	for _, client in pairs(buf_clients) do
		if client.name ~= "null-ls" and client.name ~= "copilot" then
			table.insert(buf_client_names, client.name)
		end

		if client.name == "copilot" then
			copilot_active = true
		end
	end

	function list_registered_providers_names(filetype)
		local s = require("null-ls.sources")
		local available_sources = s.get_available(filetype)
		local registered = {}
		for _, source in ipairs(available_sources) do
			for method in pairs(source.methods) do
				registered[method] = registered[method] or {}
				table.insert(registered[method], source.name)
			end
		end
		return registered
	end
	function list_registered(filetype)
		local registered_providers = list_registered_providers_names(filetype)
		local providers_for_methods = vim.tbl_flatten(vim.tbl_map(function(m)
			return registered_providers[m] or {}
		end, alternative_methods))
		return providers_for_methods
	end

	function formatters_list_registered(filetype)
		local registered_providers = list_registered_providers_names(filetype)
		return registered_providers[null_ls.methods.FORMATTING] or {}
	end

	local supported_linters = list_registered(buf_ft)
	vim.list_extend(buf_client_names, supported_linters)
	local unique_client_names = vim.fn.uniq(buf_client_names)

	local language_servers = " " .. table.concat(unique_client_names, ", ") .. ""

	if copilot_active then
		language_servers = language_servers .. "%#SLCopilot#" .. " "
	end

	return language_servers
end

lualine.setup({
	options = {
		globalstatus = true,
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "packer", "neo-tree", "nvim-tree" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = {
			custom_icons,
			modes,
		},
		lualine_b = {
		},
		lualine_c = {
      spaces,
			{
				"filetype",
				icon_only = true,
				colored = true,
				padding = 1,
				color = { bg = "#2a2c3f" },
				separator = { left = "", right = "" },
			},
			{
				"filename",
        file_status = false,
				padding = 0.3,
				separator = { left = "", right = "" },
				color = { bg = "#2a2c3f" },
			},
			branch,
			diff,
		},
		lualine_x = {
			diagnostics,
			{
				lsp_progess,
			},
			{
				function()
					return ""
				end,
				separator = { left = "", right = "" },
				color = { bg = "#8FBCBB", fg = "#000000" },
				padding = 0.3,
			},
			{
				indent,
			},
			{
				function()
					return " "
				end,
				separator = { left = "", right = "" },
				color = { bg = "#ECD3A0", fg = "#000000" },
				padding = 0.3,
			},
			"progress",
			{
				function()
					return "󰆤 "
				end,
				separator = { left = "", right = "" },
				color = { bg = "#86AAEC", fg = "#000000" },
				padding = 0.1,
			},
			location,
		},
		lualine_y = {},
		lualine_z = {},
	},
})
	end },
	{'projekt0n/circles.nvim', lazy = true,
	config = function()
	require("circles").setup({
	  icons = { empty = "", filled = "", lsp_prefix = "" },
	  lsp = true
	})
	end },
	{ "nvim-tree/nvim-web-devicons"},
	{'rebelot/kanagawa.nvim',
	config = function()
		require('kanagawa').setup({
    compile = false,             -- enable compiling the colorscheme
    undercurl = true,            -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true},
    statementStyle = { bold = true },
    typeStyle = {},
    transparent = true,         -- do not set background color
    dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
    terminalColors = true,       -- define vim.g.terminal_color_{0,17}
    colors = {                   -- add/modify theme and palette colors
        palette = {},
        theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
    },
    overrides = function(colors) -- add/modify highlights
        return {}
    end,
    theme = "wave",              -- Load "wave" theme when 'background' option is not set
    background = {               -- map the value of 'background' option to a theme
        dark = "wave",           -- try "dragon" !
        light = "lotus"
    },
})
				vim.cmd([[colorscheme kanagawa-dragon]])
		local theme = require("kanagawa.colors").setup().theme
		local kanagawa = {}
		kanagawa.normal = {
		  a = { bg = theme.syn.fun, fg = theme.ui.bg_m3 },
		  b = { bg = theme.diff.change, fg = theme.syn.fun },
		  c = { bg = theme.ui.bg_p1, fg = theme.ui.fg },
		}

		kanagawa.insert = {
		  a = { bg = theme.diag.ok, fg = theme.ui.bg },
		  b = { bg = theme.ui.bg, fg = theme.diag.ok },
		}

		kanagawa.command = {
		  a = { bg = theme.syn.operator, fg = theme.ui.bg },
		  b = { bg = theme.ui.bg, fg = theme.syn.operator },
			}

		kanagawa.visual = {
		  a = { bg = theme.syn.keyword, fg = theme.ui.bg },
		  b = { bg = theme.ui.bg, fg = theme.syn.keyword },
		}

		kanagawa.replace = {
		  a = { bg = theme.syn.constant, fg = theme.ui.bg },
		  b = { bg = theme.ui.bg, fg = theme.syn.constant },
		}

		kanagawa.inactive = {
		  a = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
		  b = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim, gui = "bold" },
		  c = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
		}
		if vim.g.kanagawa_lualine_bold then
		  for _, mode in pairs(kanagawa) do
		    mode.a.gui = "bold"
		  end
		end
		return kanagawa
		end, }
		})
