#!/bin/bash
source ./Colors.sh
char=false
dictionary=false
verbose=false
show_banner=true
# echo -n "qwerty789" | md5sum | awk '{print $1}'

function ctrl_c(){
  echo -e "\n${bright_red}[!] Deteniendo programa...\n\n${end}"
  tput cnorm && exit 1
}


trap ctrl_c INT

function helpPanel(){
  banner
  echo -e "${bright_blue}[+]${bright_white} Modo de uso:${bright_green} $0${bright_white} -c [CADENA] -w [WORDLIST]"
  echo -e "\t${bright_blue}-c${bright_white} Le pasamos una cadena MD5 para ser creackada"
  echo -e "\t${bright_blue}-w${bright_white} Le pasamos un diccionario con posibles contraseñas."
  echo -e "\t${bright_blue}-x${bright_white} Ocultar el banner."
  echo -e "\t${bright_blue}-h${bright_white} Mostrar el panel de ayuda.\n"

}

function banner(){
  echo
  [[ "$show_banner" == true ]] && figlet "Md5 Crack" -c -w '100' -k | lolcat 
}

function crack_md5(){
  tput civis
  character="$1"
  wordlist="$2"
  local attemps=0

  /usr/bin/clear

  [[ $show_banner == true ]] && banner
  if [[ ! -f $wordlist ]]; then
    echo -e "\n${bright_red}[!] No such file or directory: $wordlist!!${end}\n\n" 1>&2
    return 1
  fi
  
  if [[ $(echo -n "$character" | wc -c ) -ne 32 ]]; then
    echo -e "\n${bright_red}[!] Error fatal!!. La cadena introducida no es valida.${end}\n" 1>&2
    return 1
  fi

  while read  line; do
    passwd=$line
    md5_hashed=$(echo -n "$line" | md5sum | awk '{print $1}')
    [[ $verbose == true ]] && echo -ne "\r\033[K${bright_cyan}[+]${bright_white} Probando contraseña: ${bright_magenta}$line${bright_white} - Valor Md5 ${bright_blue}$md5_hashed${end}" 
    ((attemps++))
    if [[ "$md5_hashed" == "$character" ]]; then
      tput cnorm
      echo -e "\n${bright_green}[+]${bright_white} Valor md5:${bright_cyan} $character"
      echo -e "${bright_green}[+]${bright_white} Valor md5 crackeado:${bright_yellow} $passwd\n"
      echo -e "${bright_blue}[*]${bright_white} Intentos para llegar a la contraseña: ${bright_cyan}$attemps${end}"
      echo 
      tput cnorm
      break
    fi
  done < "$wordlist"
}

while getopts 'c:w:hvx' opt; do
  case $opt in
    h) ;;
    x) show_banner=false;;
    v) verbose=true;;
    c) character="$OPTARG"; char=true;;
    w) wordlist="$OPTARG"; dictionary=true;;
    *) echo -e "\n${bright_red}[!] Invalid Option: $1${end}\n\n"
      helpPanel
       exit 1
       ;;

  esac
done 

if [[ $char == true && $dictionary == true ]]; then
  crack_md5 "$character" "$wordlist"
else
  helpPanel
fi
