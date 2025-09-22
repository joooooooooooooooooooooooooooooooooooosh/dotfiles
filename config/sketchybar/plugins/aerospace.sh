#!/usr/bin/env sh

# Leave mouse.scrolled.global to the aerospace-mode module
if [ "${SENDER}" = "mouse.scrolled" ]; then
    if echo "${SCROLL_DELTA}" | grep -q '-'; then
        aerospace list-workspaces --monitor focused --empty no | grep -v scratchpad | aerospace workspace --wrap-around prev
    else
        aerospace list-workspaces --monitor focused --empty no | grep -v scratchpad | aerospace workspace --wrap-around next
    fi
elif [ "${SENDER}" = "aerospace_workspace_change_${1}" ]; then
    if [ "${1}" = "${FOCUSED_WORKSPACE}" ]; then
        sketchybar --set "${NAME}" background.drawing=on
    else
        # When we navigate away from a space, check if it should still be on the bar
        if [ "$(aerospace list-windows --workspace "${1}" --count)" -eq 0 ]; then
            sketchybar --remove "${NAME}" event "aerospace_workspace_change_${1}"
        fi

        # Check if the new space has an element on the bar yet
        if ! sketchybar --query "space.${FOCUSED_WORKSPACE}" >/dev/null 2>&1; then
            direction="after"
            clone_space=$({
                sketchybar --query bar | jq -r '.items[]' | sed -n 's/^space\.//p'
                echo "${FOCUSED_WORKSPACE}" # see where it fits in the sorted list
            } | sort -n | grep -x -B1 -m1 "${FOCUSED_WORKSPACE}" | sed '$d')

            if [ -z "${clone_space}" ]; then
                # New space is the first in the list
                clone_space=$(sketchybar --query bar | jq -r '.items[]' | sed -n 's/^space\.//p' | head -1)
                direction="before"
            fi

            sketchybar --add event "aerospace_workspace_change_${FOCUSED_WORKSPACE}"
            sketchybar --clone "space.${FOCUSED_WORKSPACE}" "space.${clone_space}" "${direction}" \
                --remove event "space.${FOCUSED_WORKSPACE}" "aerospace_workspace_change_${clone_space}" \
                --subscribe "space.${FOCUSED_WORKSPACE}" "aerospace_workspace_change_${FOCUSED_WORKSPACE}" \
                --set "space.${FOCUSED_WORKSPACE}" \
                icon="${FOCUSED_WORKSPACE}" \
                click_script="aerospace workspace ${FOCUSED_WORKSPACE}" \
                script="plugins/aerospace.sh ${FOCUSED_WORKSPACE}" \
                background.drawing=on
        fi
        sketchybar --set "${NAME}" background.drawing=off
    fi

    # Backup method for setting the focused workspace
    # Sometimes apps steal focus multiple times, leaving all workspaces convinced they don't have focus
    if ! aerospace list-workspaces --monitor focused --empty no |
        xargs -I{} sketchybar --query space.{} 2>/dev/null |
        jq -r .geometry.background.drawing |
        grep -x on; then
        sketchybar --set "space.$(aerospace list-workspaces --focused)" background.drawing=on
    fi
fi
