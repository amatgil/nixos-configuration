#!/usr/bin/env bash
set -euo pipefail

xrandr --output DP1 --primary --mode 1920x1080 --output HDMI2 --mode 1440x900 --left-of DP1
