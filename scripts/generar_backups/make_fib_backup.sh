#!/bin/sh
set -e # Cancel on error

source ~/scripts/generar_backups/.env

echo "Sincronitzant documents FIB"
mkdir "$DIR_TEMP"/FIB
rsync -avP "$DIR_FIB" "$DIR_TEMP"/FIB

