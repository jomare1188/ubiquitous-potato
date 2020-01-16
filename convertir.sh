#!/bin/bash
# Carpeta base
BASEDIR=/home/pi/Telegram2Icecast_muto
########################################
cd $BASEDIR
# va a carpeta base
mkdir convertidos -p
# hace una carpeta para meter los archivos que se cambian de formato
let a=1
let b=${a}-1
let c=$a-2
# contadores para que solo hayan 3 listas en todo momento
# ciclo infinito para que vaya revisando cuando llegan audios nuevos
while :
do
   cd $BASEDIR
   cd audio
   # los audios llegan a la carpeta audios
   ls | grep "oga" > lista_${a}
   # lista todos los archivos oga en la carpeta y los pone en la lista a lista
   # se pregunta si la lista b esta vacia (necesario para que corre el primer ciclo sin problemas)  
   if [ -f "${BASEDIR}/audio/lista_${b}" ]; then
       # saca las diferencias listas a y b esta diferencia son los archivos que faltan por convertir y lo guarda en un archivo llamado working
       diff lista_${a} lista_${b} | sed 1d | cut -f2 -d">" -d" " > working
    else
	# si la lista b no tiene nada es el primer ciclo y debe convertir lo que haya en la lista a
	cat lista_${a} > working
     fi
   # se pregunta si el archivo working no esta vacio
   if [ -s working ] ; then
        for i in $(cat working) ; do 
	    # si hay algo en working convierte todos los archivos que estan alli a mp3
	    sleep 1
	    ffmpeg -hide_banner -loglevel panic  -i "$i" -acodec libmp3lame -ac 2  $BASEDIR/convertidos/${i/.oga}.mp3 #2&>/dev/null
            echo "audio ${i} pasados a .mp3"
	    # borra los .oga que ya convirtio a .mp3
	    rm ${i} -v
        done
    else
         echo NO HA LLEGADO NADA NUEVO
    fi
    sleep 10
    rm lista_${c}
    let a++
    let b++
    let c++
done
