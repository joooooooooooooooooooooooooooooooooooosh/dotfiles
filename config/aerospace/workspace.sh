#!/usr/bin/env sh

{
    aerospace list-workspaces --monitor focused --empty no
    aerospace list-workspaces --focused # for when the focused workspace is empty
} |
    grep -xv scratchpad |
    sort -un |
    aerospace workspace --stdin --wrap-around "${1}"
