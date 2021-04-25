文件  : 5TX2源码编译scikit-image.txt
作者  : Michael Cong
日期  : 2020/08/08
邮箱  : rencong_jx@163.com

# 一、快速安装opencv
如果对opencv功能和版本需求不大的话，可以直接安装Python和C++的版本
```
   sudo apt-get install python-opencv
   sudo apt-get install libopencv-dev
   ```
安装完成可以直接使用，但在C++编译时候可能会出现找不到动态库，此时需要配置opencv动态库。

# 二、TX2+jetpack4.4源码编译opencv+contrib
1. 安装依赖环境
```
sudo apt-get purge libopencv*
sudo apt-get purge python-numpy
sudo apt-get autoremove
sudo apt-get update
sudo apt-get upgrade 
sudo apt-get install --only-upgrade g++-5 cpp-5 gcc-5
sudo apt-get install build-essential make cmake cmake-curses-gui g++ libavformat-dev libavutil-dev libswscale-dev libv4l-dev libeigen3-dev libglew-dev libgtk2.0-dev
sudo apt-get install libdc1394-22-dev libxine2-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
sudo apt-get install libjpeg8-dev libjpeg-turbo8-dev libtiff5-dev libjasper-dev libpng12-dev libavcodec-dev
sudo apt-get install libxvidcore-dev libx264-dev libgtk-3-dev libatlas-base-dev gfortran
sudo apt-get install libopenblas-dev liblapack-dev liblapacke-dev
sudo apt-get install qt5-default
```
2. 绑定Python2-Python3
```
# Python 2.7
sudo apt-get install -y python-dev  python-numpy  python-py  python-pytest
# Python 3.6
sudo apt-get install -y python3-dev python3-numpy python3-py python3-pytest
# GStreamer support
sudo apt-get install -y libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev 
```
3. 下载opencv源码   

下载opencv，下载地址：https://opencv.org/releases/
点击Sources进行下载自己需要的版本，我下载的是3.4.10，亲测成功，其他版本也可以。
解压opencv到home下，然后将opencv_contrib解压到opencv目录下。
```
cd 
cd opencv
mkdir build 
cd build
```
新建CmakeList.txt,将下面cmake指令填写进去，
cmake指令
```
cmake \  
    -DCMAKE_BUILD_TYPE=Release \  
    -DCMAKE_INSTALL_PREFIX=/usr/local \  
    -DBUILD_PNG=OFF \  
    -DBUILD_TIFF=OFF \  
    -DBUILD_TBB=OFF \  
    -DBUILD_JPEG=OFF \  
    -DBUILD_JASPER=OFF \  
    -DBUILD_ZLIB=OFF \  
    -DBUILD_EXAMPLES=OFF \  
    -DBUILD_opencv_java=OFF \  
    -DBUILD_opencv_python2=ON \  
    -DBUILD_opencv_python3=ON \  
    -DENABLE_PRECOMPILED_HEADERS=OFF \  
    -DWITH_OPENCL=OFF \  
    -DWITH_OPENMP=OFF \  
    -DWITH_FFMPEG=ON \  
    -DWITH_GSTREAMER=OFF \  
    -DWITH_GSTREAMER_0_10=OFF \  
    -DWITH_CUDA=ON \  
    -DWITH_GTK=ON \  
    -DWITH_VTK=OFF \  
    -DWITH_TBB=ON \  
    -DWITH_1394=OFF \  
    -DWITH_OPENEXR=OFF \  
    -DCUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-10.0 \  
    -DCUDA_ARCH_BIN="6.2" \  
    -DOPENCV_EXTRA_MODULES_PATH = /home/nvidia/OpenCV-4.3.0/opencv_contrib-4.3.0/modules \
    -DCUDA_ARCH_PTX="" \  
    -DINSTALL_C_EXAMPLES=ON \  
    -DINSTALL_TESTS=OFF \  
    -DOPENCV_TEST_DATA_PATH="" \  
    ../opencv  
```
然后执行
```
cmake ..
make -j7 
```
漫长的等待
```
sudo make install 
```
最后配置环境
```
sudo gedit /etc/ld.so.conf
```
在文件中加上一行 
```
include /usr/loacal/lib
```
其中/user/loacal是opencv安装路径也就是makefile中指定的安装路
```
运行sudo ldconfig
```
修改bash.bashrc文件，
```
sudo gedit /etc/bash.bashrc 
```
在文件末尾加入：
```
PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
export PKG_CONFIG_PATH
```
然后在命令行中输入
```
source /etc/bash.bashrc
```
至此，opencv编译完成，按照如上流程一般不会出现问题。
在命令行中输入如下命令：
```
pkg-config opencv --modversion
```
