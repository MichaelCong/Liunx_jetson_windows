#!/bin/sh

cd `dirname $0`
pwd
SCRIPT_DIR=$(pwd)
echo $SCRIPT_DIR


PYTHON_VERSION=v3.9.2

chmod +x ./build_Python_sub.sh
./build_Python_sub.sh $PYTHON_VERSION

