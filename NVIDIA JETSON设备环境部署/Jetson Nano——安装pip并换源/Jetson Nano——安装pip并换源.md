Jetson Nano——安装pip并换源

#1.更新软件源
```
sudo apt-get update
sudo apt-get upgrade
```
#2.安装pip
```
python2:  
sudo apt-get install python-pip  
python3:  
sudo apt-get install python3-pip  
升级一下pip保证是最新版的：  
pip install --upgrade pip
pip3 install --upgrade pip
```
#3.换源
通过编辑pip的配置文件进行设置，方法如下：
```
修改 ~/.pip/pip.config：
mkdir ~/.pip
vim ~/.pip/pip.conf
```
添加内容如下：
```
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
[install]
trusted-host = https://pypi.tuna.tsinghua.edu.cn
```
