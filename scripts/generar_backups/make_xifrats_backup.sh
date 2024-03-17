#!/bin/sh
set -e # Cancel on error

source ~/scripts/generar_backups/.env

echo "Sinronitzant xifrats"
mkdir "$DIR_TEMP"/xifrats
rsync -avP /home/casenc/Dropbox/xifrats "$DIR_TEMP"/xifrats
