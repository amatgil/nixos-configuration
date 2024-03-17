#/bin/bash

sed -n '/START_KEYBINDS/,/END_KEYBINDS/p' $HOME/.config/awesome/rc.lua |\
	sed -e 's/^[ \t]*//g' -e 's/[{]description = /+++> /' \
	-e 's/awful\.key(//g' -e 's/function ()//g' \
	-e 's/, group.*//g' -e "s/awful.*//g" \
	-e 's/modkey/Super/g' -e 's/[{] //g' \
	-e 's/[}],//g' -e 's/"//g' \
	-e 's/Super, \s*/Super, /g' \
	-e 's/Shift   /Shift, /g' \
	-e 's/Control /Control, /g' \
	-e 's/,$/,/g' \
	-e  '/START_KEYBINDS/d' \
	-e  '/END_KEYBINDS/d' 
