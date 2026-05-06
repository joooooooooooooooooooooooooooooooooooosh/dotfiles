#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title New Chrome window
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🌐

# Documentation:
# @raycast.author Josh Harcombe

use framework "AppKit"
use scripting additions

property NSWorkspace : a reference to current application's NSWorkspace
property NSURL : a reference to current application's NSURL
property NSFileManager : a reference to current application's NSFileManager

set theURL to NSURL's URLWithString:"https://www.apple.com"
set browserPath to (NSWorkspace's sharedWorkspace)'s URLForApplicationToOpenURL:theURL
set browserName to ((NSFileManager's defaultManager's displayNameAtPath:(browserPath's |path|))'s stringByDeletingPathExtension) as text

tell application browserName to make new window
tell application "System Events" to key code 53 # Press Esc to close Raycast window
