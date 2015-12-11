#!/bin/bash

#Funcion para terminar el script con limpieza general.
function finish() {
  clear
  banner
  infoline
  rm -f /tmp/sismoslist.txt
  tput cup 14 0
  tput setaf 3
  echo -e "[STATUS] SismoBot ha terminado.                                                     "
  tput sgr0
  tput cnorm
  exit 0
}

#Funcion para terminar el script si se usa el argumento -l con limpieza general.
function finishl() {
  banner
  infoline
  cat /tmp/sismoslist.txt
  rm -f /tmp/sismoslist.txt
  tput setaf 3
  echo
  echo -e "[STATUS] SismoBot ha terminado.                                                     "
  tput sgr0
  tput cnorm
  exit 0
}
function infoline() {
    echo
    echo "Para ver la lista de los últimos sismos correr \"./sismobot.sh -l\"" 
    echo
    echo
}


#Trampa para CONTROL-C
trap finish SIGINT SIGQUIT SIGTSTP

#Codigos de estilo
esc=`echo -en "\033"`
cc_red="${esc}[0;31m"
cc_green="${esc}[0;32m"
cc_yellow="${esc}[0;33m"
cc_blue="${esc}[0;34m"
cc_normal=`echo -en "${esc}[m\017"`
underline=`tput smul`
nounderline=`tput rmul`
bold=`tput bold`

#Titulo
function banner() {
    tput civis
    tput clear
    tput bold
    tput setaf 2
    echo "                                                                 "
    echo "                                                                 "
    echo "███████╗██╗███████╗███╗   ███╗ ██████╗ ██████╗  ██████╗ ████████╗"
    echo "██╔════╝██║██╔════╝████╗ ████║██╔═══██╗██╔══██╗██╔═══██╗╚══██╔══╝"
    echo "███████╗██║███████╗██╔████╔██║██║   ██║██████╔╝██║   ██║   ██║   "
    echo "╚════██║██║╚════██║██║╚██╔╝██║██║   ██║██╔══██╗██║   ██║   ██║   "
    echo "███████║██║███████║██║ ╚═╝ ██║╚██████╔╝██████╔╝╚██████╔╝   ██║   "
    echo "╚══════╝╚═╝╚══════╝╚═╝     ╚═╝ ╚═════╝ ╚═════╝  ╚═════╝    ╚═╝   "
    echo "-Reporte de sismos en Nicaragua- por @kikeonline /Sheep Head Apps"
    echo "                                                                 "
    tput sgr0
}
banner

if [ "$1" = "-l" ]; then
    curl http://webserver2.ineter.gob.ni/geofisica/sis/events/nicaragua.local -s -o /tmp/sismoslist.txt
    tput cup 14 0
    tput setaf 3
    echo -e "[STATUS] Últimos reportes de INETER...                                                                    "
    tput sgr0
    finishl
else
    :
fi

echo
echo "Para ver la lista de los últimos sismos correr \"./sismobot.sh -l\"" 
read -e -s -p "Presiona [ENTER] para empezar o [CTRL]-[C] para salir en cualquier momento...";
echo

tput sgr0
tput setaf 6
echo
echo -e "[STATUS] Por empezar el modo EN VIVO...                                                                   " 
tput sgr0

while true 
do
getSismos="`curl http://webserver2.ineter.gob.ni/geofisica/sis/events/nicaragua.local -s -# | iconv -c | head -1`"
localSismos="`cat /tmp/sismoslist.txt 2>&1 | iconv -c | head -1`"
noweb=""
if [[ $getSismos = $localSismos ]]; then
    tput cup 14 0
    tput setaf 6
    echo -e "[STATUS] Esperando sismo...\r                              \r[STATUS] Esperando sismo               "
    tput cup 14 0
    tput setaf 6
    echo "[STATUS] Esperando sismo.     "
    sleep 2
    tput cup 14 0
    tput setaf 6
    echo "[STATUS] Esperando sismo..     "
    sleep 2
    tput cup 14 0
    tput setaf 6
    echo "[STATUS] Esperando sismo...     "
    sleep 2
elif [[ $getSismos = $noweb ]]; then
    tput cup 14 0
    tput setaf 1
    echo "[STATUS] NO SE PUDO CONECTAR                                                     "
    tput cup 14 0
    tput setaf 1
    echo "[STATUS] NO SE PUDO CONECTAR.                                                    "
    sleep 1
    tput cup 14 0
    tput setaf 1
    echo "[STATUS] NO SE PUDO CONECTAR..                                                   "
    sleep 1
    tput cup 14 0
    tput setaf 1
    echo "[STATUS] NO SE PUDO CONECTAR...                                                  "
    sleep 5
else
    tput cup 14 0
    tput setaf 2
    echo "[STATUS] NUEVO SISMO!                                    "
    tput sgr0
    tput cup 16 0
    #tput rc
    curl http://webserver2.ineter.gob.ni/geofisica/sis/events/nicaragua.local -s -o /tmp/sismoslist.txt
    mag="`cat /tmp/sismoslist.txt 2>&1 | iconv -c | awk '{print $6}' | head -1`"
    profundidad="`cat /tmp/sismoslist.txt 2>&1 | iconv -c | awk '{print $5}' | head -1`"
    lugar="`cat /tmp/sismoslist.txt 2>&1 | iconv -c | awk '{print $7, $8, $9}' | head -1`"
    #tput sc
    echo "--------------------------------------------------------"
    echo
    echo -e "${cc_green}ÚLTIMO SISMO:${cc_normal} $lugar de ${cc_green}${underline}$mag${nounderline}${cc_normal} - ↓$profundidad KM de profundidad."
    tput sgr0
    echo "${cc_blue}[REPORTE DE INETER]:" $getSismos ${cc_normal}
    #Quitar el comment si desea mandar notificaciones a MAC OS
    #osascript -e "display notification \"$lugar\" with title \"SismoBot\" subtitle \"$mag\" sound name \"Purr\""
    sleep 5
fi
done