#!/bin/bash
source ./Colors.sh
show_banner=true

function ctrl_c(){
  echo -e "\n${bright_red}[!] Saliendo...${end}\n\n"
  [[ -d "temp_extraction" ]] && rm -rf temp_extraction
  exit 1
}
trap ctrl_c INT

declare -i counter=0

function helpPanel(){
  [[ "$show_banner" == true ]] && figlet "DestroyZip" | lolcat

  echo -e "\n${bright_blue}[+]${bright_white} Herramienta diseñada para romper contraseñas de archivos .zip\n${end}"
  echo -e "${bright_cyan}Uso:${bright_green} $0${bright_white} [PARAMS] [ARGS]${end}\n"
  echo -e "\t${bright_cyan}-w${bright_white} Indicas una wordlist, un diccionario de posibles contraseñas."
  echo -e "\t${bright_cyan}-z${bright_white} Indicas el archivo '.zip' a romper"
  echo -e "\t${bright_cyan}-x${bright_white} Ocultar el banner"
  echo -e "\t${bright_cyan}-h${bright_white} Mostrar el panel de ayuda\n"

}

function CrackZip(){
  local attemps=0
  [[ "$show_banner" == true ]] && figlet "DestroyZip" | lolcat
  zip="$1"
  wordlist="$2"

  if [[ ! -f "$zip" ]]; then
    echo -e "\n${bright_red}[!] Fatal Error: No such file or directory${end} ${bg_bright_red}$zip${end}\n"
    exit 1
  fi 1>&2

  if [[ ! -f "$wordlist" ]]; then
    echo -e "\n${bright_red}[!] Fatal Error: No such file or directory${end} ${bg_bright_red}$wordlist${end}\n"
    exit 1
  fi 1>&1
  
  if ! file test.zip | grep -oP "Zip archive data, at least v2.0 to extract" &>/dev/null; then
    echo -e "\n${bright_red}[+] Error fatal, este archivo no parece un .zip!!${end}"
    exit 1
  fi 1>&2

  while read password; do
    [[ -d "temp_extraction" ]] || mkdir temp_extraction 
    echo -ne "${bright_cyan}\r\033[K[+]${bright_white} Intentando con la contraseña:${end} ${bright_magenta}$password${end}"
    ((attemps++))
    unzip -o -P  $password -d temp_extraction "$1" &>/dev/null 
    if [[ $? -eq 0 ]]; then
      echo -e "\n${bright_cyan}[+]${bright_white} Contraseña encontrada:${bright_magenta} $password${end}"
      echo -e "${bright_magenta}[+]${bright_white} Intentos para romper la contraseña:${bright_cyan} $attemps${end}"
      echo -e "\n${bright_blue}[+]${bright_white} Archivos extraidos en el directorio:${sky} temp_extraction${end}"
      break
    fi
  done < "$wordlist"
}

while getopts 'z:w:hx' opt; do
  case $opt in
    h) ;;
    x) show_banner=false;;
    z) zip="$OPTARG"; ((counter++));;
    w) wordlist="$OPTARG"; ((counter++));;
  esac
done 

if [[ $counter -eq 2 ]]; then
  CrackZip "$zip" "$wordlist"
else
  helpPanel
fi

