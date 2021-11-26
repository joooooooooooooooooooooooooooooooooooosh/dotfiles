#!/bin/bash
colors=()
for i in `cat ~/.cache/wal/colors`;  do
    colors+=($i)
done

ZATHURA_JSON="$HOME/Documents/scripts/zathura.json"
ZATHURA_CONFIG="$HOME/.config/zathura/zathurarc"

sed -i "
/page/s/#.*\"/${colors[0]}\"/;
/text/s/#.*\"/${colors[7]}\"/;
/background/s/#.*\"/${colors[0]}\"/;
/highlight/s/#.*\"/${colors[9]}\"/;
/highlight_active/s/#.*\"/${colors[2]}\"/;
/error/s/#.*\"/${colors[3]}\"/
" $ZATHURA_JSON

~/go/bin/zathuraconf -f $ZATHURA_JSON

# oh boy, zathuraconf overwrites everything else so we gotta replace it here
# if this gets too extensive i'll just make my own zathuraconf
sed -i "/set font/s/\".*\"/\"Source Code Pro 13\"/" $ZATHURA_CONFIG
echo -e "\n# Bonus Mappings" >> $ZATHURA_CONFIG
echo "map ; focus_inputbar :" >> $ZATHURA_CONFIG
