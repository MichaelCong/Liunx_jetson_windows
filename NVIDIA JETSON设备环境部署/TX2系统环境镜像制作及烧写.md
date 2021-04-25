# @文件: TX2系统环境镜像制作与烧写
# @作者: Michael Cong
# @日期: 2020/09/14
# @邮箱: rencong_jx@163.com

传统TX2采用JetPack刷机的方法来部署板子的环境，对于单个板子而言没有问题，但对于大批量的TX2板子，如果都采用同样的方法、重复的操作来部署系统环境，无疑是一件很费时间的事情。如果有了母板，即配置好环境的板子，可以通过制作镜像的方法来快速复制板子的环境，达到快速部署的目的。
一、准备工作
1、带有Ubuntu系统的宿主机，可在windows上安装VMvare虚拟机来实现（注意虚拟机要有足够的硬盘空间，最好大于100G），这里建议使用双系统。
2、USB-Micro USB数据线一根。注意：有些线仅支持充电不支持数据传输。
3、原TX2开发板及待部署环境的新TX2开发板。
4、在NVIDIA官网下载TX2驱动包以及示例系统
Tegra186_Linux_R28.1.0_aarch64.tbz2
Tegra_Linux_Sample-Root-Filesystem_R28.1.0_aarch64.tbz
(本文使用L4T R32.3.1版本的系统)下载链接：https://developer.nvidia.com/embedded/downloads
   
注意：下载与自己TX2环境版本一致的安装包，那么如何查看自己的版本，打开TX2的命令窗口，输入<head -n 1 /etc/nv_tegra_release>
 
二、宿主机环境部署
1、将上述文件拷贝到宿机home文件夹下。
2、执行命令解压文件生成文件夹 Linux_for_Tegra。
<sudo tar -vxjf Tegra186_Linux_R32.3.1_aarch64.tbz2>
3、进入文件夹，把Tegra_Linux_Sample-Root-Filesystem_R32.3.1_aarch64.tbz2文件放到该目录下，解压文件，运行命令
cd Linux_for_Tegra/rootfs
sudo tar -jxpf Tegra_Linux_Sample-Root-Filesystem_R32.3.1_aarch64.tbz2 
cd ..
sudo ./apply_binaries.sh
三、镜像备份工作
已经有一块完全部署好深度学习环境的TX2时，可以使用命令备份该TX2的系统镜像，用于后期快速给新开发板刷写系统。
1、用USB-Micro USB数据线连接宿主机和TX2。
2、TX2进入recovery模式：按机器上的POWER键后，长按RECOVERY键并点按RESET键即可进入recovery 模式，最后依次松开POWER和RECOVERY键；可在Ubuntu主机上输入lsusb，当输出包含如下内容表示成功进入recovery模式。
Bus 001 Device 004: ID 0955:7c18 NVidia Corp.
3、宿主机进入Linux_for_Tegra 目录。
<cd Linux_for_Tegra/>
4、执行镜像备份命令。
sudo ./flash.sh -r -k APP -G {文件绝对路径} jetson-tx2 mmcblk0p1
例如：
<sudo ./flash.sh -r -k APP -G /home/rencong/Linux_for_Tegra/bootloader/system.img jetson-tx2 mmcblk0p1>
或者#sudo ./flash.sh -r -k APP -G backup.img jetson-tx2 mmcblk0p1
【注】文件路径可自定义,文件后缀名为*.img
四、镜像恢复工作
使用已有的镜像刷写新TX2。
1、用USB-Micro USB线连接宿主机与TX2。
2、TX2进入recovery模式：按机器上的POWER键后，长按RECOVERY键并点按RESET键即可进入recovery 模式，最后依次松开POWER和RECOVERY键；可在Ubuntu主机上输入lsusb，当输出包含如下内容表示成功进入recovery模式。（同样可使用lsusb命令查看连接是否成功）
3、宿主机进入Linux_for_Tegra 目录
cd Linux_for_Tegra/
4、将备份过的镜像文件拷贝到 Linux_for_Tegra/bootloader/下（如果是自定义的保存路径）
5、将镜像文件重命名为 system.img
6、执行镜像恢复命令:
sudo ./flash.sh -r jetson-tx2 mmcblk0p1
刷写完毕后可以检查新板子系统环境是否完备。
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
