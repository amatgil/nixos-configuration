#!/usr/bin/env bash
set -euo pipefail

xrandr --output DP1 --off --output HDMI1 --off --output HDMI2 --primary --mode 1440x900
