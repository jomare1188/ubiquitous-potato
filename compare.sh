#!/bin/bash
# ARCHIVOS DE ENTRADA
INPUT_1=ahrd_output_FINALANOTATION_Ttherm.csv
INPUT_2=ahrd_output_FINALANOTATION_Thmale.csv
INPUT_3=ahrd_output_FINALANOTATION_Thherm.csv
## columnas que quiero extraer
field_1=2
field_2=4
field_3=5
## cambio de variable para que no queden los nombres de las variables tan largos
i1=$field_1
i2=$field_2
i3=$field_3
## extraigo de los archivos de entrada las columnas de interes y quito los headers y creo archivos nuevos filtrados
cut $INPUT_1 -f $i1,$i2,$i3 | grep ^# -v | grep ^$ -v  > Ttherm_columns_${i1}_${i2}_${i3}
cut $INPUT_2 -f $i1,$i2,$i3 | grep ^# -v | grep ^$ -v  > Thmale_columns_${i1}_${i2}_${i3}
cut $INPUT_3 -f $i1,$i2,$i3 | grep ^# -v | grep ^$ -v  > Thherm_columns_${i1}_${i2}_${i3}

## hago las comparaciones para la columna que me interesa utilizando los archivos filtrados que acabe de crear
## ########################################################################## IMPORTANTE #############################################################################

# las columnas se enumeran por orden de aparicion en el archivo, por lo que la columna 2 en el archivo original es la columna 1 en los archivos filttrados, la columna 4 en los originales es la 2 en los filtrados y la columna 5 de los originales corresponde a la 3 en los filtrados  

######################################################################################################################################################################

## aca se pone la columna que se quiere utilizar para hacer la comparacion entre los archivos teniendo en cuenta lo anterior
FIELD=3

cut Ttherm_columns_${i1}_${i2}_${i3} -f $FIELD | sort -u > Ttherm_col_${FIELD}
cut Thmale_columns_${i1}_${i2}_${i3} -f $FIELD | sort -u > Thmale_col_${FIELD}
cut Thherm_columns_${i1}_${i2}_${i3} -f $FIELD | sort -u > Thherm_col_${FIELD}

echo Columna de referencia $FIELD
echo Ttherm vs Thmale
echo se comparten $(comm -1 -2 Ttherm_col_${FIELD} Thmale_col_${FIELD} | wc -l) genes en ambas listas
echo genes en solo en Ttherm $(comm -2 -3 Ttherm_col_${FIELD} Thmale_col_${FIELD} | wc -l)
echo genes en solo en Thmale $(comm -1 -3 Ttherm_col_${FIELD} Thmale_col_${FIELD} | wc -l)
echo
echo Ttherm vs Thherm
echo se comparten $(comm -1 -2 Ttherm_col_${FIELD} Thherm_col_${FIELD} | wc -l) genes en ambas listas
echo genes solo en Ttherm $(comm -2 -3 Ttherm_col_${FIELD} Thherm_col_${FIELD} | wc -l)
echo genes solo en Thherm $(comm -1 -3 Ttherm_col_${FIELD} Thherm_col_${FIELD} | wc -l)
echo
echo Thmale vs Thherm
echo se comparten $(comm -1 -2 Thmale_col_${FIELD} Thherm_col_${FIELD} | wc -l) genes en ambas listas
echo genes solo en Thmale $(comm -2 -3 Thmale_col_${FIELD} Thherm_col_${FIELD} | wc -l)
echo genes solo en Thherm $(comm -1 -3 Thmale_col_${FIELD} Thherm_col_${FIELD} | wc -l)
