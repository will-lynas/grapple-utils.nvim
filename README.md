# grapple-utils.nvim

A collection of small utility functions for `grapple.nvim`

## `lazy.nvim` setup

```lua
{
	"will-lynas/grapple-utils.nvim",
	version = "*",
	dependencies = {
		"cbochs/grapple.nvim",
	},
}
```

## API

Move the current mark to a specified index in the list of marks

```lua
require("grapple-utils").move_to_index({ index = 1 }) -- moves to the start
require("grapple-utils").move_to_index({ index = -1 }) -- moves to the end
```

Move the current mark to the start or end of the list of marks

```lua
require("grapple-utils").move_to_start()
require("grapple-utils").move_to_end()
```

Move the current mark up or down the list of marks

```lua
require("grapple-utils").move_up()
require("grapple-utils").move_down()
```
