#!/bin/sh
set -e # Cancel on error

source ~/scripts/generar_backups/.env

echo "Sincronitzant obsidian"
mkdir "$DIR_TEMP"/obsidian
rsync -avP "/home/casenc/HDD/ObsidianVaults" "$DIR_TEMP"/obsidian
