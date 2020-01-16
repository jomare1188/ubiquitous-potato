in=mito.vert.fasta
out=ok.fasta

awk '{if(NR==1) {print $0} else {if($0 ~ /^>/) {print "\n"$0} else {printf $0}}}' $in > fasta_una_linea.fa
mkdir -p  ordenadas_por_genero
rm ./ordenadas_por_genero/* encontrados.txt 2>/dev/null
while read i
do
    grep --no-group-separator -A1 ${i} fasta_una_linea.fa >> ./ordenadas_por_genero/genero_${i}.fa
    if [ -s "./ordenadas_por_genero/genero_${i}.fa" ] 
    then
		echo genero $i encontrado en ${in}
		echo ${i} >> encontrados.txt
    else
		rm ./ordenadas_por_genero/genero_${i}.fa
    fi
done < generos
cat ./ordenadas_por_genero/genero_* > ${out}
