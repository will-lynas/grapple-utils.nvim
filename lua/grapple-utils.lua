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

return M
