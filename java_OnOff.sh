#!/bin/bash

# enable or disable this java globally
# Скрипт включает или выключает нужную вервию java системно.
# нужно скачать и положить нужную версию примеру в /usr/local/java/
# Затем положить в корень этой версиии данный скрипт к примеру сюда : /usr/local/java/jdk1.6.0_27/THIS_SCRIPT.SH
# После включить или выключить нужную версию JAVA так (root or sudo ).
#
# cd / /usr/local/java/jdk1.6.0_27/
# chmod +x java_OnOff.sh
# ./java_OnOff.sh (enable|disable|status)

# set -x

JDIR="$(pwd)/bin/"
JAVA=$JDIR\java
SYSDIR="/usr/bin/"
JSYS=$SYSDIR\java

if [[ ! -f $JAVA ]]; then
  echo -e '\e[1;31m' "$JAVA не существует. Скрипт должен лежать в корне распакованной папки с JAVA !" '\e[0m'
  exit 1
fi



jenable () {
  for name in $(ls $JDIR); do
    ln -s $JDIR$name $SYSDIR$name
  done
}

jdisable () {
  for name in $(ls $JDIR); do
    rm $SYSDIR$name
  done
}

jstatus () {
  if [[ -h $JSYS ]]; then
    echo -e '\e[1;32m' "JAVA включена" '\e[0m' 
    ls -lah $JSYS
  elif [[ ! -f $JSYS ]]; then
    echo -e '\e[1;31m' "JAVA вЫключена" '\e[0m' 
  fi
}


case "$1" in
  enable)
  if [[ -f $JSYS ]]; then
    echo -e '\e[1;31m' "JAVA уже включена" '\e[0m' 
    ls -lah $JSYS
    exit 1
  else
    echo -e '\e[1;32m' "enabled java $JDIR" '\e[0m'
    jenable
  fi
  exit 0
  ;;
  disable)
  if [[ ! -h $JSYS ]]; then
    echo -e '\e[1;31m' "JAVA уже вЫключена" '\e[0m' 
    exit 1
  elif [[ $(ls -la $JSYS | awk '{print $NF}') != $JAVA ]]; then
    echo -e '\e[1;31m' "Включена другая версия JAVA" '\e[0m' 
    ls -lah $JSYS
    exit 1
  else
    echo -e '\e[1;32m' "disabled java $JDIR" '\e[0m'
    jdisable
  fi
  exit 0
  ;;
  status)
  jstatus
  exit 0
  ;;
  *)
    echo -e '\e[1;36m' "Usage: $0 {enable|disable|status}" '\e[0m'
    exit 1
esac

