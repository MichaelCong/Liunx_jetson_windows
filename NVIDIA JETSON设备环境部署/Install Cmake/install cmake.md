文件  : 4TX2安装cmake.txt  
作者  : Michael Cong  
日期  : 2020/08/08  
邮箱  : rencong_jx@163.com

# 一、TX2升级cmake软件包
我的应用场景要编译TensorRT进行目标检测，yolo-darknet/tkCUDNN，需要最低cmake版本为3.15,而Jetpack 4.3刷机后自带的为3.12.
使用以下两条命令都是失败的
```shell
sudo pip3 install cmake==3.18
sudo apt-get install python3-cmake
```
因此，只能从源码安装camke。  
1. 删除默认的cmake    
```
sudo apt remove cmake
sudo apt purge --auto-remove cmake
```
2. 从官网下载所需版本，解压，创建build文件夹  
```
sudo apt-get install libssl-dev
sudo apt-get install build-essential
$ wget https://cmake.org/files/v3.18/cmake-3.18.0.tar.gz
$ tar xf cmake-3.18.0.tar.gz
$ cd cmake-3.18.0
$ ./configure
$ make -j7
$ sudo make install
```

3. 移动路径
```
sudo cp ./bin/cmake /usr/bin/
```

4. 验证安装结果 
``` 
cmake --version
```
输出  
```
cmake version 3.13.3
CMake suite maintained and supported by Kitware (kitware.com/cmake).
```