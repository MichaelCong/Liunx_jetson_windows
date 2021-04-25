# install PaddlePaddle
安装方式有两种：pip安装或源码安装

## 源码安装"Jetson Nano上部署飞桨PaddleDection 原生预测方法经验分享"
1. 环境准备  
安装Jetson TX2版本JP 4.4.1，官方镜像已经预装了OpenCV、CUDA、CUDNN、TensorRT等依赖环境。  
#Apt源更改：https://zhuanlan.zhihu.com/p/69849653  
#中文输入法配置：https://blog.csdn.net/u013617229/article/details/89645829  
#Python源更改：https://blog.csdn.net/sinat_21591675/article/details/82770360  
#jetson-stats：Jetson 状态查看工具，用于查看设备的资源占用情况以及许多软件的版本信息，例如OpenCV、CUDA、TensorRT。  

2. 安装方法：
    ``` 
    sudo apt-get install python3-pip
    sudo -H python3 -m pip install jetson-stats
    (需要重启)  , 使用指令：jtop  
    ``` 
    #开启jetson clock
    ```
    sudo nvpmodel -m 0 
    sudo jetson_clocks
    ```

2. pip安装  
pip install paddlepaddle-gpu
paddle version

