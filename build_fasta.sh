#!/bin/bash
# Funcion para crear un archivo fasta a partir de las secuencias y los headers en archivos de texto planto
build_fasta () {
    # $1 headers
    # $2 secuencias
    n=1
    rm build.fa 2>/dev/null
    for i in $(cat $1)
    do
	cat $1 | awk -v line="$n" 'FNR == line {print}' >> built.fa
	cat $2 | awk -v line="$n" 'FNR == line {print}' >> built.fa
	let n++
    done
}
build_fasta $1 $2
