local M = {}

function M.setup() end

function M.move_to_end()
	local grapple = require("grapple")
	local current_path = vim.api.nvim_buf_get_name(0)
	local opts = { path = current_path }
	if grapple.exists(opts) then
		grapple.untag(opts)
		grapple.tag(opts)
	end
end

function M.move_up()
	local grapple = require("grapple")
	local current_path = vim.api.nvim_buf_get_name(0)
	local current_opts = { path = current_path }
	local tags, err = grapple.tags()

	if not tags then
		vim.notify("No tags available: " .. err, vim.log.levels.WARN)
		return
	end

	if grapple.exists(current_opts) then
		local current_index = nil
		for i, tag in ipairs(tags) do
			if tag.path == current_path then
				current_index = i
				break
			end
		end
		if current_index and current_index > 1 then
			local prev_index = current_index - 1
			tags[current_index], tags[prev_index] = tags[prev_index], tags[current_index]
			for i = 1, #tags do
				grapple.untag({ path = tags[i].path })
				grapple.tag({ path = tags[i].path })
			end
			grapple.select(current_opts)
		else
			vim.notify("Cannot move up: Current tag is the first in the list or not found", vim.log.levels.INFO)
		end
	else
		vim.notify("Current buffer is not tagged", vim.log.levels.INFO)
	end
end

function M.move_down()
	local grapple = require("grapple")
	local current_path = vim.api.nvim_buf_get_name(0)
	local current_opts = { path = current_path }
	local tags, err = grapple.tags()

	if not tags then
		vim.notify("No tags available: " .. err, vim.log.levels.WARN)
		return
	end

	if grapple.exists(current_opts) then
		local current_index = nil
		for i, tag in ipairs(tags) do
			if tag.path == current_path then
				current_index = i
				break
			end
		end
		if current_index and current_index < #tags then
			local next_index = current_index + 1
			tags[current_index], tags[next_index] = tags[next_index], tags[current_index]
			for i = 1, #tags do
				grapple.untag({ path = tags[i].path })
				grapple.tag({ path = tags[i].path })
			end
			grapple.select(current_opts)
		else
			vim.notify("Cannot move down: Current tag is the last in the list or not found", vim.log.levels.INFO)
		end
	else
		vim.notify("Current buffer is not tagged", vim.log.levels.INFO)
	end
end

return M
