#!/usr/bin/env sh

PREFERRED_MIC="Razer Siren Mini"
PREFERRED_OUTPUT="External Headphones"
PREFERRED_BLUETOOTH="LinkBuds S"

BLUETOOTH_OUTPUT=$(blueutil --paired 2>/dev/null | grep "name: \"${PREFERRED_BLUETOOTH}\"" | cut -d' ' -f2 | sed 's/,$//')
if [ -n "$BLUETOOTH_OUTPUT" ]; then
        blueutil --connect "${BLUETOOTH_OUTPUT}"
        PREFERRED_OUTPUT=${PREFERRED_BLUETOOTH}
fi

INPUT_DEVICE="MacBook Pro Microphone"
if SwitchAudioSource -a -t input | grep -q "${PREFERRED_MIC}"; then
        INPUT_DEVICE="${PREFERRED_MIC}"
fi

SwitchAudioSource -t input -s "${INPUT_DEVICE}"

if SwitchAudioSource -a -t output | grep -q "${PREFERRED_OUTPUT}"; then
        SwitchAudioSource -t output -s "${PREFERRED_OUTPUT}"
fi
