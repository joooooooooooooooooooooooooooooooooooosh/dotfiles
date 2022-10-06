#!/bin/bash

offending_files="
/home/joshh/.config/i3/config
/etc/xdg/picom.conf
"
# offending_files="test"

for f in $offending_files; do
    # TODO: will not recalculate for each IF GAPS block
    no_has_gaps=$(grep -A1 "##### IF GAPS" $f | tail -1 | grep -q "^#"; echo $?)
    if [ $no_has_gaps -ne 0 ]; then
        nvim -es $f <<EOF
/##### IF GAPS/+1,/##### ELSE/-1 s/^/# /
/##### ELSE/+1,/##### END/-1 s/# //
w
EOF
    else
        nvim -es $f <<EOF
/##### IF GAPS/+1,/##### ELSE/-1 s/# //
/##### ELSE/+1,/##### END/-1 s/^/# /
w
EOF
    fi
done

i3-msg restart
