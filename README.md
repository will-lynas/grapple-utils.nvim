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

Move the current mark to the end of the list of marks

```lua
require("grapple-utils").move_to_end()
```

Move the current mark up or down the list of marks

```lua
require("grapple-utils").move_up()
require("grapple-utils").move_down()
```
