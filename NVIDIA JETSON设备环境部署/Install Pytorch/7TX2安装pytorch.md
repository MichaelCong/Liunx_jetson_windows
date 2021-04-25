日期  : 2020/09/03  
邮箱  : rencong_jx@163.com

# Jetson TX2安装pytorch 1.4 (jetpack4.3)详细教程  
参考：https://github.com/riskybacon/tx2-pytorch-wheelbuilder/tree/master/scripts    
https://github.com/andrewadare/jetson-tx2-pytorch    
https://forums.developer.nvidia.com/t/pytorch-for-jetson-nano-version-1-6-0-now-available/72048    
whl需要翻墙下载，需要的联系邮箱，我发给您，麻烦star一下。    
```shell
pytorch1.7百度云：
链接：https://pan.baidu.com/s/1A10bMh8qeNaIvULzZm5rPg  
提取码：cong  
```

## 1、TX2 更改python默认版本为python 3
TX2 刷完jetpack4.5固件后安装的ubuntu系统同时存在两个版本的python，一个是默认的python2.7,另一个是python3.6版本，我一般习惯使用python3,所以通过以下命令进行设置。  
```
sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 100

sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 150
```

在弹出的列表中进python默认版本的选择 
 
```
sudo update-alternatives --config python  
```  
执行下面命令安装pip3   
``` 
sudo apt-get install python3-pip python-pip  
```  

更新版本    

```
pip3 install --upgrade pip   
pip install -U pip  
```

## 2、安装pytorch
### 2.1 Jetson TX2必要依赖安装
为了能在TX2上顺利的进行一系列的软件安装工作，我建议在TX2刷机完毕后可以安装以下依赖，这样可以避免后续安装pytrorch等第三方库出现不必要的错误。  
```  
sudo apt-get -y update  

sudo apt-get -y upgrade
```

依赖Dependencies：  

sudo apt-get install -y nano curl python3-dev python-setuptools python3-setuptools python3-opencv libcanberra-gtk0 libcanberra-gtk-module 

针对Python-pip：  
pip3 install setuptools wheel  
pip install setuptools wheel cython

### 2.2 Pytorch安装
TX2安装Pytorch最简单的方法就是下载nvidia官网提供的对应版本的pytorch的whl文件和教程进行安装，nvidia官方pythorch下载地址。  
本次选择的是安装的python 3.6版本的pytorch1.8.0版本。  
安装的方式有很多种：  

第一种方法：通过wget下载whl文件有时会比较慢甚至下载失败，我是在windows环境下用利用科学上网下载，速度会比较快，下载好后将文件放在home目录下然后执行后面3步。   

###### Python 3.6    
wget https://nvidia.box.com/shared/static/p57jwntv436lfrd78inwl7iml6p13fzh.whl -O torch-1.8.0-cp36-cp36m-linux_aarch64.whl  
sudo apt-get install python3-pip libopenblas-base libopenmpi-dev   
pip3 install Cython  
pip3 install numpy torch-1.8.0-cp36-cp36m-linux_aarch64.whl  

###### Python 2.7  注意(PyTorch v1.4.0 for L4T R32.4.2 is the last version to support Python 2.7)  
wget https://nvidia.box.com/shared/static/1v2cc4ro6zvsbu0p8h6qcuaqco1qcsif.whl -O torch-1.4.0-cp27-cp27mu-linux_aarch64.whl  
sudo apt-get install libopenblas-base libopenmpi-dev   
pip install future torch-1.4.0-cp27-cp27mu-linux_aarch64.whl  

第二种方法：没有亲自试过，主要通过pip换清华源的方式下载安装，个人觉得不要使用豆瓣等源因为他们不一定包含TX2 ARM的安装包，可以自己尝试一下，下载速度应该也比较快。  
pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple numpy torch-1.4.0-cp36-cp36m-linux_aarch64.whl  
BUG:  安装完成后可以在python环境下通过import torch进行验证，可能会报错如下:  
我的是应为numpy版本的问题，通过以下命令行将其版本更新至1.19.1即可解决问题。  
pip3 install --upgrade numpy

### 2.3 安装Torchvision v0.9.0 
sudo apt-get install libjpeg-dev zlib1g-dev libpython3-dev libavcodec-dev libavformat-dev libswscale-dev

git clone --branch v0.9.0 https://github.com/pytorch/vision torchvision   # see below for version of torchvision to download    
(国内加速镜像：https://github.com.cnpmjs.org/pytorch/vision)  #实测用手机热点下载会比较顺利(注意pytorch版本与torchvision版本相对应)  
```
参考对应表： 

Select the version of torchvision to download depending on the version of PyTorch that you have installed:     

PyTorch v1.0 - torchvision v0.2.2  

PyTorch v1.1 - torchvision v0.3.0  

PyTorch v1.2 - torchvision v0.4.0  

PyTorch v1.3 - torchvision v0.4.2  

PyTorch v1.4 - torchvision v0.5.0  

PyTorch v1.5 - torchvision v0.6.0  

PyTorch v1.6 - torchvision v0.7.0  

PyTorch v1.7 - torchvision v0.8.1 
 
PyTorch v1.8 - torchvision v0.9.0  

```

cd torchvision  
export BUILD_VERSION=0.9.0  
sudo python3 setup.py install --user  
cd ../  # attempting to load torchvision from build dir will result in import error  
可选：  
pip3 install 'pillow<7' # not needed for torchvision v0.5.0+

pip install 'pillow<7' # always needed for Python 2.7, not needed torchvision v0.5.0+ with Python 3.6

进行到sudo python3 setup.py install这一步时，报错如下：  
from torch._C import * import torch No module named 'numpy.core._multiarray_
应该是安装pillow的过程失败了。  
通过下面的语句可实现加速安装pillow，便可解决问题，然后接着执行后面的语句。  
pip3 install -i https://pypi.tuna.tsinghua.edu.cn/simple pillow==4.1.1

## 2.4 安装验证
通过一下命令进行安装验证。  
python3 -c "import torch ; print(torch.__version__);print(torchvision.__version__)"
