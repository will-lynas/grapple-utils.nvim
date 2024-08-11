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

Move the current tag to a specified index in the list of tags

```lua
require("grapple-utils").move_to_index({ index = 2 })
require("grapple-utils").move_to_index({ index = -2 }) -- moves to the second to last position
```

Move the current tag to the start or end of the list of tags

```lua
require("grapple-utils").move_to_start()
require("grapple-utils").move_to_end()
```

Move the current tag up or down the list of tags

```lua
require("grapple-utils").move_up()
require("grapple-utils").move_down()
```
