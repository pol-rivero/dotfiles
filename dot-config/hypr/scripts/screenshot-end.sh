#!/bin/bash

# For some reason, when using --early-exit with satty, the screenshot is not copied correctly.
# This script is a workaround for that issue.

wl-copy
killall satty
