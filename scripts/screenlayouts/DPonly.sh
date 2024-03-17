#!/usr/bin/env bash
set -euo pipefail

xrandr --output HDMI1 --off --output HDMI2 --off --output DP1 --mode 1920x1080 --primary
