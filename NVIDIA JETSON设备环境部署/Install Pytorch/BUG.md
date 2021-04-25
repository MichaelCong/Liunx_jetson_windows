NVIDIA JETSONTX2 安装 pytorch 出现错误：import torch 出现 Illegal instruction(core dumped)
https://blog.csdn.net/weixin_42899627/article/details/115000645


遇到的问题
python3 进入命令行
>>>import torch
Illegal instruction(cpre dumped)
>>>import numpy
Illegal instruction(cpre dumped)
![ava](https://img-blog.csdnimg.cn/2021031910305869.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80Mjg5OTYyNw==,size_16,color_FFFFFF,t_70)

解决方法
'''修改环境变量'''
sudo gedit /etc/profile 
把 export OPENBLAS_CORETYPE=ARMV8 加入最后面一行，然后保存
'''更新环境变量'''
source /etc/profile
![ava](https://img-blog.csdnimg.cn/20210319103947347.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80Mjg5OTYyNw==,size_16,color_FFFFFF,t_70)
![ava](https://img-blog.csdnimg.cn/20210319103330938.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80Mjg5OTYyNw==,size_16,color_FFFFFF,t_70)

TIP:  
NVIDIA官网安装pytorch教程：PyTorch for Jetson - version 1.8.0 now available [https://forums.developer.nvidia.com/t/pytorch-for-jetson-version-1-8-0-now-available/72048]  
Jetson Tx2 用不了 nvidia-smi 命令  

参考文章
1 解决英伟达Jetson平台使用Python时的出现“Illegal instruction(cpre dumped)”错误
[https://xiaosongshine.blog.csdn.net/article/details/114168235]
2 Illegal instruction(core dumped) error on Jetson Nano
[https://www.reddit.com/r/JetsonNano/comments/ktcyoh/illegal_instructioncore_dumped_error_on_jetson/]