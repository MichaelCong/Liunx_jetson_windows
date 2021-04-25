# OpenCV build script for Tegra
This script builds OpenCV from source on Tegra (Nano, TX1, TX2, NX, AGX, etc.).

## Usage:
```
./build_opencv.sh
#Specifying an OpenCV version (git branch)
./build_opencv.sh 4.4.0  
```
**JetPack 4.4 NOTE:**   
The minimum version that will build correctly on JetPack 4.4 GA is 4.4.0. Prior versions of JetPack may need the CUDNN version adjusted (the `-D CUDNN_VERSION='8.0'` line can simply be removed).

如有权限问题，则执行下列操作。
```
sudo chmod 777 install.sh
./install.sh
```

