安装完系统后首先应该更新源，否则后续更新和升级会非常慢。但是由于Jetson Nano采用的是aarch64架构的Ubuntu 18.04.2 LTS系统，与AMD架构的Ubuntu系统不同，因此需要替换成aarch64的源，这里一定要注意，不要替换成x86-64的源了。  

我们这里选择清华的源进行更新。
1、首先备份原本的源，更改source.list文件的名字，以备不时之需：  
```
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak 
```   
2、更换源：  
```
sudo gedit /etc/apt/sources.list
```
gedit后会弹出如下窗口，将除所有内容删除，粘贴以下内容并点击保存按钮：
![avatar](https://img-blog.csdnimg.cn/20201222160922163.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDM1MDMzNw==,size_16,color_FFFFFF,t_70)
```
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic main multiverse restricted universe
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic-security main multiverse restricted universe
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic-updates main multiverse restricted universe
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic-backports main multiverse restricted universe
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic main multiverse restricted universe
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic-security main multiverse restricted universe
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic-updates main multiverse restricted universe
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic-backports main multiverse restricted universe
```
3、换源进行软件更新。  
打开终端，输入下述命令进行软件更新：
```
sudo apt-get update
sudo apt-get full-upgrade
```
更新时间较长，中间可能由于网速的关系会更新失败，此时不要关机重启，重新执行命令即可，会自动断点续传的。

如果出现下面的错误执行下面的命令删除锁定文件即可：
![avatar](https://img-blog.csdnimg.cn/20201222161405584.png)
删除锁定文件：
sudo rm /var/lib/dpkg/lock-frontend       
sudo rm /var/lib/dpkg/lock
