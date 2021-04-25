@文件  : 1TX2更换软件源.txt  
@作者  : Michael Cong  
@日期  : 2020/08/08  
@邮箱  : rencong_jx@163.com  
## Jetson TX2更换软件源，建议使用方法二。
方法一：  
TX2的软件源为国外服务器，网速会很慢，需要换国内的ARM源。  
备份/etc/lib路径下的source.list文件，然后在终端（按ctrl+alt+T打开）执行以下命令：  
```
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak    
#为防止误操作后无法恢复，先备份原文件sources.list
sudo gedit /etc/apt/sources.list  
#打开sources.list，将原来的内容使用”#”符号全部注释掉，然后在文件结尾出添加中国科学技术大学或清华的源
```
将文件改为国内源（注意修改之前先将原文件备份），还有一点要注意，换源需要换ARM的源，不要换成了pc平台的软件源。这里推荐两个国内源，将原来文件里面的内容全部替换成下面两个源之一就可以：
```
清华源：
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ xenial-updates main restricted universe multiverse  
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ xenial-updates main restricted universe multiverse   
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ xenial-security main restricted universe multiverse   
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ xenial-security main restricted universe multiverse   
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ xenial-backports main restricted universe multiverse   
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ xenial-backports main restricted universe multiverse   
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ xenial main universe restricted   
deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ xenial main universe restricted 
科大的源：
deb http://mirrors.ustc.edu.cn/ubuntu-ports/ xenial-updates main restricted universe multiverse 
deb-src http://mirrors.ustc.edu.cn/ubuntu-ports/ xenial-updates main restricted universe multiverse 
deb http://mirrors.ustc.edu.cn/ubuntu-ports/ xenial-security main restricted universe multiverse 
deb-src http://mirrors.ustc.edu.cn/ubuntu-ports/ xenial-security main restricted universe multiverse 
deb http://mirrors.ustc.edu.cn/ubuntu-ports/ xenial-backports main restricted universe multiverse 
deb-src http://mirrors.ustc.edu.cn/ubuntu-ports/ xenial-backports main restricted universe multiverse 
deb http://mirrors.ustc.edu.cn/ubuntu-ports/ xenial main universe restricted 
deb-src http://mirrors.ustc.edu.cn/ubuntu-ports/ xenial main universe restricted
```
替换之后，执行
```
sudo apt-get update
```
## 方法二：
目前使用成功的源：建议使用。
```
# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu-ports/ bionic-security main restricted universe multiverse
```
主要是两个点：  
ubuntu-ports: Arm架构适用  
bionic: ubuntu18.04
```
sudo apt-get update
sudo apt-get upgrade
```
