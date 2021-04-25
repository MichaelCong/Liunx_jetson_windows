sudo apt -y install libhdf5-serial-dev hdf5-tools python3-pip python3-venv
python3 -m venv $1
cd $1/bin
source activate
pip3 install pip -U 
pip3 install --extra-index-url https://developer.download.nvidia.com/compute/redist/jp/v42 tensorflow-gpu
