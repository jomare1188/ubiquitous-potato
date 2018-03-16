#!/bin/bash
#script para filtrar los peptidos de menor e-value de cada categoria
######### doy formato al archivo ################################

cp ensayoThherm test # insertar el nombre del archivo a filtrar en ensayoThherm

echo dandole formato al archivo 

sed -i 's/|/ /g' test # quito los palos esos
sed -i 's/|/ /g' test # quito los palos esos
sed -i $'s/\t/ /' test # quito los tab
sed -i $'s/\t/ /' test # quito los tab
sed -i $'s/\t/ /' test # quito los tab
sed -i $'s/\t/ /' test # quito los tab
sed -i $'s/\t/ /' test # quito los tab
sed -i $'s/\t/ /' test # quito los tab
sed -i $'s/  / /' test # quito doble espacio
sed -i $'s/  / /' test # quito doble espacio 
sed -i $'s/  / /' test # quito doble espacio
sed -i $'s/  / /' test # quito doble espacio 
sed -i $'s/  / /' test # quito doble espacio
sed -i $'s/  / /' test # quito doble espacio 


echo extrayendo primera columna
############################ extraigo la primera columna #################################################3
cut -d " " -f 1 test > cut_1.txt
uniq cut_1.txt > uniq_cut_1.txt

echo ordenando cada peptido en orden segun columna No 11
############################ creo una variable con las categorias de la primera columna ######################
mapfile -t peptidos < uniq_cut_1.txt
while IFS= read -r line;  do echo ">>$line<<"; done < uniq_cut_1.txt


################################ busco el menor e-value (columna 10) para cada categoria de la primera columna ###############
limite=${#peptidos[@]}                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
a=0
echo son $limite categorias de peptidos

while [ $limite -ge $a ]
do

grep -w "${peptidos[a]}" test | sort -g -k 10,10 | grep -m 1 "${peptidos[a]}" >> orderered.txt


let a=$a+1
echo ciclo $a

done 
