#!/bin/bash

while getopts "e:p:l:" OPT; do
  case $OPT in
    e) ENV_NAME=$OPTARG ;;
    p) PYTHON_VERSION=$OPTARG ;;
    l) set -f
       IFS=' '
       PACKAGES=($OPTARG)
       ;;
    ?) echo "Script usage: $(basename $0)"
       echo "       [-e environment name]"
       echo "       [-p Python version]" 
       echo "       [-l packages list [...]]" >&2
       ;;
  esac
done

cd ~/python
dir_name=$(date +"%m-%d-%y")
mkdir pyday-$dir_name
cd pyday-$dir_name
virtualenv $ENV_NAME -p /usr/bin/python$PYTHON_VERSION
source $ENV_NAME/bin/activate

for package in "${PACKAGES[@]}"; do
  pip install ${package}
done

clear

echo " -------------------------------------------------"
echo "        '$ENV_NAME' environment setup complete           "
echo " -------------------------------------------------"
echo ""
