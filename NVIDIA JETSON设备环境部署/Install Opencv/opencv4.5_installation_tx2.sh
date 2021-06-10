#!/bin/bash
# -*- coding：utf-8 -*-
version="4.5.0"
folder="opencv-4.5.0"
echo "** 首先删除TX2设备上的opencv版本......"
sudo sudo apt-get purge *libopencv*
echo "** 安装依赖项......"
sudo apt-get update
sudo apt-get upgrade 
sudo apt-get install -y build-essential cmake git libgtk2.0-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev
sudo apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
sudo apt-get install -y qt5-default
sudo apt-get install qtbase5-dev
sudo apt-get install qtdeclarative5-dev
sudo apt-get install -y python2.7-dev python3.6-dev python-dev python-numpy python3-numpy
sudo apt-get install -y libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev libdc1394-22-dev
sudo apt-get install -y libv4l-dev v4l-utils qv4l2 v4l2ucp
sudo apt-get install -y curl

# Python 2.7
sudo apt-get install -y python-dev  python-numpy  python-py  python-pytest
# Python 3.6
sudo apt-get install -y python3-dev python3-numpy python3-py python3-pytest
# GStreamer support
sudo apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev 

echo "** ......正在下载 opencv-"${version}
mkdir $folder
cd ${folder}
curl -L https://github.com.cnpmjs.org/opencv/opencv/archive/${version}.zip -o opencv-${version}.zip
curl -L https://github.com.cnpmjs.org/opencv/opencv_contrib/archive/${version}.zip -o opencv_contrib-${version}.zip
unzip opencv-${version}.zip
unzip opencv_contrib-${version}.zip
cd opencv-${version}/

echo "** 编译opencv..."
mkdir build
cd build/
cmake -D WITH_CUDA=ON -D WITH_CUDNN=ON -D CUDA_ARCH_BIN="7.2" -D CUDA_ARCH_PTX="" -D OPENCV_GENERATE_PKGCONFIG=ON -D OPENCV_EXTRA_MODULES_PATH=/home/nvidia/opencv/opencv_contrib-4.5.1/modules -D WITH_GSTREAMER=ON -D WITH_LIBV4L=ON -D WITH_QT=ON -D WITH_GTK=ON -D BUILD_opencv_python3=ON -D PYTHON_DEFAULT_EXECUTABLE=/usr/bin/python3 -D BUILD_TESTS=OFF -D BUILD_PERF_TESTS=OFF -D BUILD_EXAMPLES=OFF -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local ..

sudo make -j$(nproc) ## 报错添加sudo试试
sudo make install
sudo ldconfig

python3 -c 'import cv2; print("python3 cv2 version: %s" % cv2.__version__)'