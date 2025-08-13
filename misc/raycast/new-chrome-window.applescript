#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title New Chrome window
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🌐

# Documentation:
# @raycast.author Josh Harcombe

tell application "Google Chrome" to make new window
tell application "System Events" to key code 53 # Press Esc to close Raycast window
