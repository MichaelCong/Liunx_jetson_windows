jetson nano 和树莓派一样作为嵌入式设备提供了GPIO接口，其位置如下图红色框选部分。[参考连接](https://blog.csdn.net/weixin_44350337/article/details/111594479)
![avatar](https://img-blog.csdnimg.cn/20201223171343333.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDM1MDMzNw==,size_16,color_FFFFFF,t_70)
其中部分引脚功能已标注丝印具体功能如下表所示：
![avatar](https://img-blog.csdnimg.cn/20201223171646481.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDM1MDMzNw==,size_16,color_FFFFFF,t_70)
这是微雪提供的引脚功能表，其中：
BCM是丝印内容  
Name是引脚名称，也代表了引脚功能，当然引脚的功能复用是单片机的基本功能  
BOARD是引脚标号这个东西在后面的编程里边会用到，但是在这个表我认为是有错的，19的右边应该是20号引脚，20号引脚的位置则应该是22号引脚，通过观察第一张图的引脚丝印就可以看出来。  
![avatar](https://img-blog.csdnimg.cn/20201223183945501.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDM1MDMzNw==,size_16,color_FFFFFF,t_70)
NVIDIA官方提供了基于python的JetsonGPIO库用来控制GPIO，这样可以方便在人工智能程序中进行GPIO控制。
### 1、环境配置和安装库
这里我使用的是jupyterLab，在官方提供的镜像中，这个是自带的，如果你没有的话需要下载安装，但是如果你有屏幕键鼠全套的话，其实也不用。    
首先在命令行输入下面的指令：    
安装Jetson.GPIO库：    
```
sudo pip install Jetson.GPIO
sudo pip3 install Jetson.GPIO
```  
设置用户权限：  
```sudo groupadd -f -r gpio
sudo usermod -a -G gpio <your_user_name>```  
注意：这里的your_user_name需要改成你自己的账号名(nvidia)，不然库无法正常使用  
将99-gpio.rules文件复制到rules.d目录  
```sudo cp lib/python/Jetson/GPIO/99-gpio.rules /etc/udev/rules.d/  ```
重载rules规则来让文件生效  
```
sudo udevadm control --reload-rules && sudo udevadm trigger  
由于官方镜像已经安装配置好了，所以没有配置截图。
```
### 2、下面对示例程序进行测试
```cd /opt/nvidia/jetson-gpio/samples/```
该文件夹中包含几个示例文件：
![avatar](https://img-blog.csdnimg.cn/20201223182315109.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDM1MDMzNw==,size_16,color_FFFFFF,t_70)
运行simple_out.py，将二极管的正极连接丝印12的针脚，负极连接一个GND针脚，LED灯就会两秒灭两秒暗。  
![avatar](https://img-blog.csdnimg.cn/2020122318212453.jpg?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDM1MDMzNw==,size_16,color_FFFFFF,t_70)
终端输出如下：  
![avatar](https://img-blog.csdnimg.cn/20201223185224652.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDM1MDMzNw==,size_16,color_FFFFFF,t_70)
有个问题就是为什么终端输出的说是在pin18，却要插在12处，和树莓派一样  
Jetson.GPIO的GPIO的设置有四种模式，模式不同同一引脚的名称就不一样。  
### 3、GPIO的使用
1 引入GPIO库  
```import Jetson.GPIO as GPIO```
2 设置引脚编号模式  
这里就对上面的四种模式进行说明：  
BOARD（the pin number of the 40 pin GPIO header）：就是引脚序号，也就是第一个图红框里边的引脚号，和丝印标注的序号是一致的。  
BCM（the Broadcom SoC GPIO numbers）：就是芯片的引脚编号。芯片的引脚编号是芯片未焊接时的从初始引脚标注起周围一圈引脚的编号。  
CVM和TEGRA_SOC使用字符串代替数字，分别对应于CVM / CVB连接器和Tegra SoC上的信号名称。  
设置方式：  
```GPIO.setmode(GPIO.BOARD)
# or
GPIO.setmode(GPIO.BCM)
# or
GPIO.setmode(GPIO.CVM)
# or
GPIO.setmode(GPIO.TEGRA_SOC)```
如果要检查当前的引脚编号模式使用下面的语句：    
```mode = GPIO.getmode()```
获得的结果mode是上面四种中的一个或者为空（None）  
3 警告  
您尝试使用的GPIO可能已在当前应用程序外部使用。在这种情况下，如果使用的GPIO配置为除默认方向（输入）以外的任何值，Jetson GPIO库将向您发出警告。如果在设置模式和通道之前尝试清理，它也会警告您。要禁用警告，请使用下面的语句：  
```GPIO.setwarnings(False)```
4 设置通道
在用作输入输出之前，针脚必须先设置GPIO输出输出模式，要将通道配置为输入使用：
```GPIO.setup(channel, GPIO.IN)```
channel是基于上边设置的四种模式下的引脚编号，如果不明白，请查看示例程序中的simple_out.py（下同）
要设置输出：
```GPIO.setup(channel, GPIO.OUT)```
要指定初始值（以初始值为高电平为例）：
```GPIO.setup(channel, GPIO.OUT, initial=GPIO.HIGH)```
一次性设置多个针脚：
```# 你可以随意的增加通道数，你也可以使用元组来代替列表: (18,12,13)  
channels = [18, 12, 13]  
GPIO.setup(channels, GPIO.OUT)```
5 输入
要读取通道（针脚）的值：
```GPIO.input(channel)```
返回值为：GPIO.LOW 或者 GPIO.HIGH.
6 输出
设置一个针脚的输出：
```GPIO.output(channel, state)```
state就是引脚状态，可以是GPIO.LOW 或者 GPIO.HIGH.
还可以将channel和state用列表或元组设置多个
```channels = [18, 12, 13] # 或使用元组
# 设置全为高（或低）
GPIO.output(channels, GPIO.HIGH) # 或GPIO.LOW
# 分别设置三个通道的电平(通道和状态数量要一致)
GPIO.output(channels, (GPIO.LOW, GPIO.HIGH, GPIO.HIGH))```
7 清理
在程序结束时最好清理通道，将引脚设置为默认状态，下面的语句就可以清理所有通道：
```GPIO.cleanup()```
如果不想清除所有通道，也可以清除单个通道或通道列表或元组：
```GPIO.cleanup(chan1) # 仅清理chan1
GPIO.cleanup([chan1, chan2]) # 仅清理chan1和chan2
GPIO.cleanup((chan1, chan2))  # 和上一句相同```
8 模块信息及版本信息
获取模块信息使用下面的语句：
```GPIO.JETSON_INFO```
返回值为字典，有以下键：P1_REVISION，RAM，REVISION，TYPE，MANUFACTURER和PROCESSOR
除了P1_REVISION的值为整数外其余键的值为字符串。
库版本的信息使用下面的语句：
GPIO.VERSION

9 中断
除了轮询外，该库还提供了三种事件监听方法：
WAIT_FOR_EDGE() 函数
他可以阻塞线程，知道检测到信号发生为止，函数调用如下：

GPIO.wait_for_edge(channel, GPIO.RISING)
1
第二个参数指定要检测的信号（该信号是上升沿、下降沿之类的信号）
如果只想将等待时间限制为指定的时间，则可以选择设置超时：

# timeout为毫秒值
GPIO.wait_for_edge(channel, GPIO.RISING, timeout=500)
1
2
该函数返回检测是否在该通道检测到对应的信号；如果发生超时，则返回无。
EVENT_DETECTED() 函数
这个函数可以检测在某一通道上是否接收到了某一信号，其使用方式如下：

GPIO.add_event_detect(channel, GPIO.RISING)
run_other_code()
if GPIO.event_detected(channel):
    do_something()
1
2
3
4
和上边一样，可以检测GPIO.RISING，GPIO.FALLING 和 GPIO.BOTH信号。
当检测到某一信号时运行回调函数
回调函数可以与主程序并发运行，因为两者不在同一个线程，使用方法如下：

# 定义回调函数
def callback_fn(channel):
    print("Callback called from channel %s" % channel)

# add rising edge detection
GPIO.add_event_detect(channel, GPIO.RISING, callback=callback_fn)
1
2
3
4
5
6
如果需要，还可以添加多个回调：

def callback_one(channel):
    print("First Callback")

def callback_two(channel):
    print("Second Callback")

GPIO.add_event_detect(channel, GPIO.RISING)
GPIO.add_event_callback(channel, callback_one)
GPIO.add_event_callback(channel, callback_two)
1
2
3
4
5
6
7
8
9
在这种情况下，这两个回调是顺序运行的，而不是同时运行，因为只有线程运行所有回调函数。
为了通过将多个事件折叠成一个事件来防止多次调用回调函数，可以选择设置弹起时间：

# bouncetime 设置的是毫秒值
GPIO.add_event_detect(channel, GPIO.RISING, callback=callback_fn,
bouncetime=200)
1
2
3
如果不再需要信号检测，则可以按以下步骤将其删除：

GPIO.remove_event_detect(channel)
1
10 检查GPIO通道的功能
使用下面的语句可以检测GPIO通道的功能：

GPIO.gpio_function(channel)
1
该函数返回GPIO.IN或GPIO.OUT。

11 PWM
请参阅示例文件samples/simple_pwm.py了解有关如何使用PWM通道的详细信息。

Jetson.GPIO库仅在附带硬件PWM控制器的引脚上支持PWM。与RPi.GPIO库不同，Jetson.GPIO库不实现软件仿真的PWM。Jetson Nano支持2个PWM通道，而Jetson AGX Xavier支持3个PWM通道。Jetson TX1和TX2不支持任何PWM通道。

系统引脚复用器必须配置为将硬件PWM控制器连接到相关引脚。如果未配置引脚复用器，则PWM信号将不会到达引脚！Jetson.GPIO库不会动态修改引脚复用器配置来实现此目的。
————————————————
版权声明：本文为CSDN博主「Dunkle.T」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/weixin_44350337/article/details/111594479