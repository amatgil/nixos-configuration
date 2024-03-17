#!/bin/sh
set -e # Cancel on error

source ~/scripts/generar_backups/.env

echo "Copiant contrasenyes"
cp "/home/casenc/Passwords.kdbx" "$DIR_TEMP"

