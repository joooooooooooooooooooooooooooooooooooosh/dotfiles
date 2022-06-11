#!/bin/sh
sed -En '/^[A-Z]+_DIR=/p; /^cp (-[^ ]+) ([^ ]+) (.*)/{s//mkdir -p \2 \&\& cp \1 \3 "$_"/; p}' \
    .dotfiles/scripts/updatedotfiles.sh \
    | sed -E '/cp -[^r] /s/^(mkdir -p )((.*)(\/[^ ]+)) (\&\& cp -u \"[^"]+)" /\1\3 \&\& echo \2 \5\4\" /'
