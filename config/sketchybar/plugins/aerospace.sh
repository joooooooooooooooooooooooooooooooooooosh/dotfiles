#!/usr/bin/env sh

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
            aerospace list-workspaces --monitor all --empty no
            echo "${FOCUSED_WORKSPACE}"
        } | grep -xv scratchpad | sort -n | grep -B1 "${FOCUSED_WORKSPACE}" | sed '$d')

        if [ -z "${clone_space}" ]; then
            clone_space=$(aerospace list-workspaces --monitor all --empty no | head -1)
            direction="before"
        fi

        sketchybar --add event "aerospace_workspace_change_${FOCUSED_WORKSPACE}"
        sketchybar --clone "space.${FOCUSED_WORKSPACE}" "space.${clone_space}" "${direction}" \
            --remove event "space.${FOCUSED_WORKSPACE}" "aerospace_workspace_change_${clone_space}" \
            --subscribe "space.${FOCUSED_WORKSPACE}" "aerospace_workspace_change_${FOCUSED_WORKSPACE}" \
            --set "space.${FOCUSED_WORKSPACE}" \
            icon="${FOCUSED_WORKSPACE}" \
            click_script="aerospace workspace ${FOCUSED_WORKSPACE}" \
            script="plugins/aerospace.sh ${FOCUSED_WORKSPACE}"
    fi
    sketchybar --set "${NAME}" background.drawing=off
fi

# Leave mouse.scrolled.global to the aerospace-mode module
if [ "${SENDER}" = "mouse.scrolled" ]; then
    if echo "${SCROLL_DELTA}" | grep -q '-'; then
        aerospace list-workspaces --monitor focused --empty no | grep -v scratchpad | aerospace workspace --wrap-around prev
    else
        aerospace list-workspaces --monitor focused --empty no | grep -v scratchpad | aerospace workspace --wrap-around next
    fi
fi
