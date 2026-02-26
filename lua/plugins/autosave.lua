return {
  "okuuva/auto-save.nvim",
  version = "^6.0.0",
  event = { "InsertLeave", "FocusLost" }, 
  config = function()
    require("auto-save").setup({
      enabled = true,
      trigger_events = { "InsertLeave", "FocusLost" },
      
      
      condition = function(buf)
        local fn = vim.fn
        local utils = require("auto-save.utils.data")
        if fn.getbufvar(buf, "&modifiable") == 1 and utils.not_in(fn.getbufvar(buf, "&filetype"), {}) then
          return true
        end
        return false
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "AutoSaveWritePost",
      callback = function(opts)
        if opts.data.saved_buffer ~= nil then
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(opts.data.saved_buffer), ":t")
          
          print("💾 Auto-save: " .. filename .. " as " .. vim.fn.strftime("%H:%M:%S"))
        end
      end,
    })
  end,
}
