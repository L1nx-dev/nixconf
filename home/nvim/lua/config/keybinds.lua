vim.keymap.set({"n", "v"}, "d", '"_d', { desc = "Delete" })
vim.keymap.set("n", "x", '"_x', { desc = "Delete character" })
vim.keymap.set("x", "x", '"+d', { desc = "Cut" })
vim.keymap.set({"n", "v"}, "c", '"_c', { desc = "Swap" })

-- vim.keymap.set("x", "P", '"_dP', { desc = "Paste before without yanking" })

-- vim.keymap.set("x", "p", function()
--   local mode = vim.fn.mode()
--
--   if mode == "V" then
--     local a = vim.fn.getpos("v")[2]
--     local b = vim.fn.getpos(".")[2]
--
--     local first = math.min(a, b) - 1
--     local last = math.max(a, b)
--
--     local content = vim.fn.getreg("+", 1, true)
--
--     vim.api.nvim_buf_set_lines(0, first, last, false, content)
--
--     -- Exit visual mode first
--     vim.cmd("normal! <Esc>")
--
--     -- Restore the previous visual selection marks
--     vim.fn.setpos("'<", { 0, first + 1, 1, 0 })
--     vim.fn.setpos("'>", { 0, first + #content, 1, 0 })
--
--     -- Position cursor on first inserted line
--     vim.api.nvim_win_set_cursor(0, { first + 1, 0 })
--   else
--     local content = vim.fn.getreg("+", 1, true)
--     local regtype = vim.fn.getregtype("+")
--
--     vim.cmd('normal! "_d')
--     vim.fn.setreg('"', content, regtype)
--     vim.cmd("normal! P")
--   end
-- end, { desc = "Paste without yanking" })

vim.keymap.set("n", "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>")

vim.keymap.set("i", "<C-BS>", "<C-w>")
vim.keymap.set("i", "<C-Del>", "<C-o>dw")


-- Tab management
vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>")
vim.keymap.set("n", "<leader>e", "<Cmd>NvimTreeFocus<CR>")


vim.keymap.set("n", "<leader>u", "<Cmd>UndotreeToggle<CR>")



-- Telescope

local function find_up(levels, opts)
  opts = opts or {}
  return function()
    local cwd = vim.fn.getcwd()
    for _ = 1, levels do
      cwd = cwd .. "/.."
    end
    opts.cwd = cwd
    require("telescope.builtin").find_files(opts)
  end
end

vim.keymap.set("n", "<leader>ff", find_up(0))
for i = 1, 9 do
  vim.keymap.set("n", "<leader>f" .. i .. "f", find_up(i))
end

vim.keymap.set("n", "<leader>fh", find_up(0, { hidden = true }))
for i = 1, 9 do
  vim.keymap.set("n", "<leader>f" .. i .. "h", find_up(i, { hidden = true }))
end

-- vim.keymap.set("n", "<leader>ff", function()
--   require("telescope.builtin").find_files()
-- end)
vim.keymap.set("n", "<leader>fg", function()
  require("telescope.builtin").live_grep()
end)
vim.keymap.set("n", "<leader>fb", function()
  require("telescope.builtin").buffers()
end)
vim.keymap.set("n", "<leader>fl", function()
  require("telescope.builtin").help_tags()
end)
-- vim.keymap.set("n", "<leader>fh", function()
--   builtin.find_files({ hidden = true })
-- end, {})


-- Comment
vim.keymap.set("n", "<leader>/", function()
  require("Comment.api").toggle.linewise.current()
end, { desc = "Comment line" })

vim.keymap.set("x", "<leader>/", function()
  local api = require("Comment.api")
  local vmode = vim.fn.mode()
  local esc = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
  vim.api.nvim_feedkeys(esc, "nx", false)
  if vmode == "V" then
    api.toggle.linewise(vmode)
  else
    api.toggle.blockwise(vmode)
  end
end, { desc = "Comment selection" })
