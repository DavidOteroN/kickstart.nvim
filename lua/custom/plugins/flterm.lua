-- Create a floatning terminal with persistent state
-- From this YT video by TJ DeVries: https://youtu.be/5PIiKDES_wc?si=W8BlzAKj1_GJMZE7

local state = {
  floating = {
    buf = -1,
    win = -1,
  },
}

local function create_floating_windot(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.width or math.floor(vim.o.lines * 0.8)

  -- Calculate the center of the window
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  -- Create a buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  -- Window config
  local win_config = {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal',
    border = 'rounded',
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

local toggle_terminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_windot { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= 'terminal' then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

vim.api.nvim_create_user_command('Flterm', toggle_terminal, {})
vim.keymap.set({ 'n', 't' }, '<c-w>f', toggle_terminal, { desc = 'Open [F]loating terminal.' })

return {}
