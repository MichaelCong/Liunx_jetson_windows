#**# Jetson Nano——SD卡系统备份#**
[https://blog.csdn.net/qq_45779334/article/details/114095742](https://blog.csdn.net/qq_45779334/article/details/114095742) 
#注意
```shell
对系统SD卡的备份和操作必须要在Linux的Host机上进行，这里我用的是Ubuntu虚拟机。
```
#1.备份系统SD卡
查看需要备份的SD卡的设备号  
sudo fdisk -l  
查看内存空间使用情况  
df -h   
这里我的SD卡设备号为/dev/sdb。 
![](https://img-blog.csdnimg.cn/20210226004609468.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQ1Nzc5MzM0,size_16,color_FFFFFF,t_70) 
# 2.备份SD卡
将需要备份的SD卡插入到Ubuntu系统中，输入备份命令：  
完整备份：  
sudo dd bs=16M if=/dev/sdb of=nano_back.img  
压缩备份：  
sudo dd if=/dev/sdb conv=sync,noerror bs=16M | gzip -c > nano_back.img.gz  
bs：bs是写入和读取速度，在我电脑上16M最大可以达到60MB/s左右的速度，可以根据自己的情况扩大，减小没必要。  
过程中不会显示进度，可以用命令查看：  
sudo pkill -USR1 -n -x dd  
#3.将备份的镜像刷到新的SD卡中
（1）Windows端烧录
采用正常烧录软件即可。
以下两种都可以：  
![](https://img-blog.csdnimg.cn/2021022614522719.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQ1Nzc5MzM0,size_16,color_FFFFFF,t_70)
![](https://img-blog.csdnimg.cn/20210226145244385.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQ1Nzc5MzM0,size_16,color_FFFFFF,t_70)
（2）Ubuntu端烧录
查看新SD卡的设备号（一般都一样）  
sudo fdisk -l  
![](https://img-blog.csdnimg.cn/20210226011740921.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQ1Nzc5MzM0,size_16,color_FFFFFF,t_70)
烧录镜像到新SD卡  
将新的SD卡插入到Ubuntu系统中，输入刷镜像命令：  
sudo dd bs=16M if=nano_back.img of=/dev/sdb  
解压缩烧录：  
sudo gunzip -c nano_back.img.gz | dd of=/dev/sdb bs=16M  
# 4.SD卡的格式化
在windows端可以通过Disk Genius软件实现对SD卡储存部分的格式化，然后通过SD Formatter实现SD卡整体的格式化即可。  
![](https://img-blog.csdnimg.cn/20210226164212253.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3FxXzQ1Nzc5MzM0,size_16,color_FFFFFF,t_70)
保存镜像  
最后可以将镜像保存在Windows本地，用7z压缩，以便未来使用。  
#参考文章：

【Jetson-Nano】SD卡系统备份克隆[https://blog.csdn.net/u011119817/article/details/109488332?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.control&dist_request_id=352040f1-ecaf-4c62-a9f4-7a43d41fde40&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.control](https://blog.csdn.net/u011119817/article/details/109488332?utm_medium=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.control&dist_request_id=352040f1-ecaf-4c62-a9f4-7a43d41fde40&depth_1-utm_source=distribute.pc_relevant.none-task-blog-BlogCommendFromMachineLearnPai2-2.control)
jetson nano TF卡镜像复制[https://blog.csdn.net/qq_37655118/article/details/105510948?utm_medium=distribute.pc_relevant.none-task-blog-baidujs_title-3&spm=1001.2101.3001.4242](https://blog.csdn.net/qq_37655118/article/details/105510948?utm_medium=distribute.pc_relevant.none-task-blog-baidujs_title-3&spm=1001.2101.3001.4242)