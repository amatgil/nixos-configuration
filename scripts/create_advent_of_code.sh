#!/bin/sh

if [ $# -eq 0 ]
  then
    echo "T'has deixat d'especificar el dia!"
	exit
fi

printf -v DIA "%02d" $1 #Emmagatzemo el numero a la var 'DIA', zero padded a 2 digits
 
if [ ! -d "./default-file" ]
  then 
	echo "No he trobat default-file, comprova que existeix al directori al que estàs"
	exit
fi

cp ./default-file/ dia-"$DIA" -r && echo "He creat dia-$DIA"

URL="https://adventofcode.com/2022/day/$1/input"
#curl $URL > "./dia-$DIA/input.data" # Doesn't work, inputs need to be logged in :(
