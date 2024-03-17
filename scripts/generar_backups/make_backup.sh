#!/bin/sh
set -e # Cancel on error

source ~/scripts/generar_backups/.env

[ ! -d "$DIR_EXTERNAL" ] && echo "No has muntat $DIR_EXTERNAL, curtet" && exit 1

echo "Tot muntat: iniciant..."

mkdir -p "$DIR_TEMP" # Crea'l si no existeix
rm -rf "$DIR_TEMP"/* # Borra lo de dins, si hi ha res

./make_passes_backup.sh
./make_xifrats_backup.sh
./make_obsidian_backup.sh
./make_fib_backup.sh


tar -czvf "/tmp/$DATE.tar.gz" "$DIR_TEMP/"
cp "/tmp/$DATE.tar.gz" "$DIR_EXTERNAL/"
cp "/tmp/$DATE.tar.gz" "$DIR_INTERNAL/"
