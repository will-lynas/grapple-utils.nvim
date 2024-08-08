local M = {}

local grapple = require("grapple")

function M.setup() end

---@param tags grapple.tag[]
---@param current_path string
---@return integer?
local function get_current_index(tags, current_path)
	for i, tag in ipairs(tags) do
		if tag.path == current_path then
			return i
		end
	end
	return nil
end

---@param opts grapple.options
function M.move_to_index(opts)
	if not opts or not opts.index then
		vim.notify("Invalid options: index is required", vim.log.levels.ERROR)
		return
	end

	local current_path = vim.api.nvim_buf_get_name(0)
	local current_opts = { path = current_path }
	if not grapple.exists(current_opts) then
		vim.notify("Current buffer is not tagged", vim.log.levels.INFO)
		return
	end

	local tags, err = grapple.tags()
	assert(tags, "No tags available: " .. (err or "unknown error"))

	local current_index = get_current_index(tags, current_path)
	if not current_index then
		vim.notify("Tag not found for the current buffer", vim.log.levels.ERROR)
		return
	end

	local new_index = opts.index
	if new_index < 0 then
		new_index = (#tags + 1) + new_index
	end

	if new_index < 1 or new_index > #tags then
		vim.notify("Invalid index: Out of bounds", vim.log.levels.ERROR)
		return
	end

	if current_index == new_index then
		vim.notify("Tag is already at the specified position", vim.log.levels.INFO)
		return
	end

	grapple.tag({ path = current_path, index = new_index })
	grapple.select(current_opts)
end

function M.move_to_start()
	M.move_to_index({ index = 1 })
end

function M.move_to_end()
	M.move_to_index({ index = -1 })
end

---@param direction integer
local function move_tag(direction)
	local current_path = vim.api.nvim_buf_get_name(0)
	local current_opts = { path = current_path }
	if not grapple.exists(current_opts) then
		vim.notify("Current buffer is not tagged", vim.log.levels.INFO)
		return
	end

	local tags, err = grapple.tags()
	if not tags then
		vim.notify("No tags available: " .. err, vim.log.levels.ERROR)
		return
	end

	local current_index = get_current_index(tags, current_path)
	if not current_index then
		vim.notify("Tag not found for the current buffer", vim.log.levels.ERROR)
		return
	end

	local new_index = current_index + direction
	if new_index < 1 or new_index > #tags then
		vim.notify("Cannot move: Current tag is at the boundary of the list", vim.log.levels.INFO)
		return
	end

	grapple.tag({ path = current_path, index = new_index })
	grapple.select(current_opts)
end

function M.move_up()
	move_tag(-1)
end

function M.move_down()
	move_tag(1)
end

---@class grapple-utils.options: grapple.options
---@field return_to_previous boolean?

---@param opts grapple-utils.options
---@return string? error
function M.select(opts)
	return grapple.select(opts)
end

return M
