## 原装的TX2只有32G的空间，安装完tensorflow等相关环境就空间已经所剩无几#使用64G的SD卡进行挂载
## 1、使用命令查看硬盘信息

sudo fdisk -lu  
主要关注这行信息  
```
Device         Boot Start       End   Sectors  Size Id Type  

/dev/mmcblk1p1      32768 124735487 124702720 59.5G  7 HPFS/NTFS/exFAT
```

## 2、修改SD卡模式
执行sudo mkfs -t ext4 /dev/sda1，将sda1格式化为ext4模式。
选择Y
mke2fs 1.42.13 (17-May-2015)
Found a dos partition table in /dev/mmcblk1p1
Proceed anyway? (y,n) y
Creating filesystem with 122096390 4k blocks and 30531584 inodes
Filesystem UUID: a1d95dae-7cb8-4ddc-b402-a1a32649c1c9
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208, 
	4096000, 7962624, 11239424, 20480000, 23887872, 71663616, 78675968, 
	102400000
 Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (32768 blocks): done
Writing superblocks and filesystem accounting information: done 
## 3、在主目录下建文件夹data并修改权限
```
sudo mkdir ~/data  
sudo chown nvidia:nvidia ~/data
```
## 4、将SD卡挂载到data文件夹下
```
sudo mount -t ext4 /dev/mmcblk1p1 ~/data/
```
## 5、使用命令查看挂载情况
df -h  
## 6、设置开机自动挂载
sudo gedit /etc/fstab
在文末添加一行，特别要注意格式的对其，否则将无法正常开机，建议复制上一行的内容进行修改
/dev/mmcblk1p1  /home/nvidia/data ext4  defaults  1  2
7、重启计算机就可以成功挂载了
sudo reboot
