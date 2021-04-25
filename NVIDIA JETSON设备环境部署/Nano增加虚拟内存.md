jetson nano 增加虚拟内存

git clone https://github.com/JetsonHacksNano/installSwapfile
cd installSwapfile/
sudo ./installSwapfile.sh

自动增加6g虚拟内存，每次上电都会自动创建。6g虚拟内存是4g的物理内存的推荐大小。也可以自己指定，具体看https://github.com/JetsonHacksNano/installSwapfile