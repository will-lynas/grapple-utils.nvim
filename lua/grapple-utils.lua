local M = {}

local grapple = require("grapple")

function M.setup() end

function M.move_to_end()
	local current_path = vim.api.nvim_buf_get_name(0)
	local opts = { path = current_path }
	if grapple.exists(opts) then
		grapple.untag(opts)
		grapple.tag(opts)
	end
end

local function get_current_index(tags, current_path)
	for i, tag in ipairs(tags) do
		if tag.path == current_path then
			return i
		end
	end
	return nil
end

local function swap_tags(tags, index1, index2)
	tags[index1], tags[index2] = tags[index2], tags[index1]
	for i = 1, #tags do
		grapple.untag({ path = tags[i].path })
		grapple.tag({ path = tags[i].path })
	end
end

local function move_tag(direction)
	local current_path = vim.api.nvim_buf_get_name(0)
	local current_opts = { path = current_path }
	local tags, err = grapple.tags()

	if not tags then
		vim.notify("No tags available: " .. err, vim.log.levels.WARN)
		return
	end

	if grapple.exists(current_opts) then
		local current_index = get_current_index(tags, current_path)

		if current_index then
			local new_index = current_index + direction

			if new_index > 0 and new_index <= #tags then
				swap_tags(tags, current_index, new_index)
				grapple.select(current_opts)
			else
				vim.notify("Cannot move: Current tag is at the boundary of the list", vim.log.levels.INFO)
			end
		else
			vim.notify("Tag not found for the current buffer", vim.log.levels.INFO)
		end
	else
		vim.notify("Current buffer is not tagged", vim.log.levels.INFO)
	end
end

function M.move_up()
	move_tag(-1)
end

function M.move_down()
	move_tag(1)
end

return M
