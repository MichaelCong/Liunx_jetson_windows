文件  : 4TX2安装cmake.txt  
作者  : Michael Cong  
日期  : 2020/08/08  
邮箱  : rencong_jx@163.com
## JetsonTX2ForDeeplearning
Setting up Jetson TX2 with OpenCV Tensorflow &amp; Keras for deep learning. I have tried a lot of online tutorials about setting up Jetson TX2. However, not all of them works. The reason is due to some of them are outdated and the libraries provided by Nvidia got upgraded. This is what I found at least working for now.  
Note: If there is any library update and for some reason, any of them is not working, let me know and I will try to update the code.  
## Keras Install
1. 新建install_keras.sh，将下列内容拷贝进文件中。
```
#!/usr/bin/env bash
set -e
set -x
echo "Install dependencies"
sudo apt-get -y install libhdf5-serial-dev hdf5-tools
# for python3
sudo -H pip3 install keras
# for python2
sudo -H pip2 install keras
```
2. 安装kears
```
./install_keras.sh
```