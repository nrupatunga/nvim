-- Shared helpers for keymaps and plugins

local M = {}

function M.get_line_range()
  local line1 = vim.fn.line("v")
  local line2 = vim.fn.line(".")
  if line1 > line2 then
    line1, line2 = line2, line1
  end
  return line1, line2
end

function M.format_ref(name, line1, line2)
  if line1 == line2 then
    return name .. ":" .. line1
  end
  return name .. ":" .. line1 .. "-" .. line2
end

function M.copy_and_notify(text)
  vim.fn.setreg("+", text)
  vim.notify("Copied: " .. text, vim.log.levels.INFO)
end

function M.exit_visual()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
end

return M
