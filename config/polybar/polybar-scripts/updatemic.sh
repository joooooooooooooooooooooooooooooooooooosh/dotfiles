#!/bin/bash
pgrep "microphone.sh" | xargs kill -USR1
