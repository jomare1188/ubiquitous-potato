grep ">" 189_orchids_CDS.fasta > headers.txt
cut -f3 -d"_" headers.txt | sort -u > genes.txt

awk '{if(NR==1) {print $0} else {if($0 ~ /^>/) {print "\n"$0} else {printf $0}}}' 189_orchids_CDS.fasta > fasta_una_linea.fa
mkdir -p ordenadas_por_gen
rm -v ordenadas_por_gen/*
for i in $(cat genes.txt)
do
    grep --no-group-separator -A1 $i fasta_una_linea.fa >> ./ordenadas_por_gen/${i}_gene.fa
done


	
