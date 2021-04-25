#!/bin/bash
echo "Start Install TensorFlow"
eval "sudo apt-get install libhdf5-serial-dev hdf5-tools libhdf5-dev zlib1g-dev zip libjpeg8-dev"
eval "sudo apt-get install python3-pip"
eval "sudo pip3 install -U pip"
eval "sudo pip3 install -U numpy grpcio absl-py py-cpuinfo psutil portpicker six mock requests gast h5py astor termcolor protobuf keras-applications keras-preprocessing wrapt google-pasta"
eval "sudo pip3 install --pre --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v42 tensorflow-gpu"
echo "Install Finish!"

