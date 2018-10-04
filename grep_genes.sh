#!/bin/bash

mapfile -t input < input_list
let counter=0
let ensayo=1

for list in $(cat list_of_lists)

do
    for genes in $(cat $list)
    do
	grep $genes ${input[${counter}]} >> result_${ensayo}
	echo buscando $genes en ${input[${counter}]} y copiando en result_${ensayo}
    done
    
    let counter++
    let ensayo++
done
