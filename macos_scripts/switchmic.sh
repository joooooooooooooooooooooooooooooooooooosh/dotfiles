#!/usr/bin/env zsh
# NOTE: if running this script using Aerospace, Aerospace needs access to Bluetooth in order to use blueutil

PREFERRED_INPUT=("Razer Seiren Mini" "MacBook Pro Microphone")
PREFERRED_OUTPUT=("External Headphones" "USB Audio CODEC " "MacBook Pro Speakers")
PREFERRED_BLUETOOTH="LinkBuds S"

BLUETOOTH_OUTPUT=$(blueutil --paired 2> /dev/null | grep "name: \"${PREFERRED_BLUETOOTH}\"" | cut -d' ' -f2,3)
if [ -n "${BLUETOOTH_OUTPUT}" ]; then
    if ! grep "connected$" <<< "${BLUETOOTH_OUTPUT}"; then
        BLUETOOTH_OUTPUT=$(cut -d, -f1 <<< "${BLUETOOTH_OUTPUT}")
        timeout 1 blueutil --connect "${BLUETOOTH_OUTPUT}"
    fi \
        && PREFERRED_OUTPUT=(${PREFERRED_BLUETOOTH}) # don't set output if the `blueutil` connect timed out
fi

for output in ${PREFERRED_OUTPUT[@]}; do
    if SwitchAudioSource -a -t output | grep -q "${output}"; then
        SwitchAudioSource -t output -s "${output}"
        used_output="${output}"
        break
    fi
done

for input in ${PREFERRED_INPUT[@]}; do
    if SwitchAudioSource -a -t input | grep -q "${input}"; then
        SwitchAudioSource -t input -s "${input}"
        used_input="${input}"
        break
    fi
done

osascript -e "display notification \"Input: ${used_input}\nOutput: ${used_output}\" with title \"Audio Settings\""
