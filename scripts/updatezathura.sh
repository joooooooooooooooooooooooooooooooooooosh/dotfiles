#!/bin/bash
colors=()
for i in `cat ~/.cache/wal/colors`;  do
    colors+=($i)
done

ZATHURA_JSON="$HOME/Documents/scripts/zathura.json"

sed -i "/page/s/#.*\"/${colors[0]}\"/" $ZATHURA_JSON
sed -i "/text/s/#.*\"/${colors[7]}\"/" $ZATHURA_JSON
sed -i "/background/s/#.*\"/${colors[0]}\"/" $ZATHURA_JSON
sed -i "/highlight/s/#.*\"/${colors[9]}\"/" $ZATHURA_JSON
sed -i "/highlight_active/s/#.*\"/${colors[2]}\"/" $ZATHURA_JSON
sed -i "/error/s/#.*\"/${colors[3]}\"/" $ZATHURA_JSON

~/go/bin/zathuraconf -f $ZATHURA_JSON
