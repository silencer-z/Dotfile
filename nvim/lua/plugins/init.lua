return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- noice 
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
      cmdline = {
        view = "cmdline_popup",
        format = {
          cmdline      = { title = "" },
          search_down  = { title = "" },
          search_up    = { title = "" },
          filter       = { title = "" },
          lua          = { title = "" },
          help         = { title = "" },
        },
      },
      views = {
        cmdline_popup = {
          border = {
            style = "none",
            padding = {1,1},
          },
          win_options = {
            winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
          }
        }
      },
    },
    
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    }
  }

}
