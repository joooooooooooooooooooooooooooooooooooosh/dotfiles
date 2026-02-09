#!/usr/bin/env zsh -x
# NOTE: if running this script using Aerospace, Aerospace needs access to Bluetooth in order to use blueutil

PREFERRED_INPUT=("Razer Seiren Mini" "MacBook Pro Microphone")
PREFERRED_OUTPUT=("External Headphones" "USB Audio CODEC " "MacBook Pro Speakers")
PREFERRED_BLUETOOTH=("WH-1000XM4" "LinkBuds S")

if [ "$(SwitchAudioSource -c -t output)" != "${PREFERRED_BLUETOOTH[1]}" ]; then
	for bluetooth in ${PREFERRED_BLUETOOTH[@]}; do
		BLUETOOTH_OUTPUT=$(blueutil --paired 2> /dev/null | grep "name: \"${bluetooth}\"" | cut -d' ' -f2,3)
		if [ -n "${BLUETOOTH_OUTPUT}" ]; then
			if ! grep "connected$" <<< "${BLUETOOTH_OUTPUT}"; then
				BLUETOOTH_OUTPUT=$(cut -d, -f1 <<< "${BLUETOOTH_OUTPUT}")
				timeout 1 blueutil --connect "${BLUETOOTH_OUTPUT}"
			fi \
				&& {
					PREFERRED_OUTPUT=(${bluetooth}) # don't set output if the `blueutil` connect timed out
					break
				}
		fi
	done

	for output in ${PREFERRED_OUTPUT[@]}; do
		if SwitchAudioSource -a -t output | grep -qx "${output}"; then
			SwitchAudioSource -t output -s "${output}"
			used_output="${output}"
			break
		fi
	done
fi

for input in ${PREFERRED_INPUT[@]}; do
	if SwitchAudioSource -a -t input | grep -qx "${input}"; then
		SwitchAudioSource -t input -s "${input}"
		used_input="${input}"
		break
	fi
done

osascript -e "display notification \"Input: ${used_input}\nOutput: ${used_output}\" with title \"Audio Settings\""
