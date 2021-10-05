#!/bin/bash
ps ax | grep "bash .*microphone.sh" | sed 's/^\s*//; s/ .*//' | xargs -I. kill -USR1 .
