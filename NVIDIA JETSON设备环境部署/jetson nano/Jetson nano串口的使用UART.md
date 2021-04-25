UART串口使用两条杜邦线就可以实现数据发送和接收，可以很方便的与其他扩展进行数据连接，比如微雪的L76X GPS HAT就可以直接连接40Pin的GPIO接口通过UART串口进行数据传递。  
接下来具体说明Jetson nano串口的使用：  
### 1、首先下图是Jetson nano的所有通讯接口，其中红框框选的8、10是我们要用到的引脚。
![avatar](https://img-blog.csdnimg.cn/20201224134429416.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDM1MDMzNw==,size_16,color_FFFFFF,t_70)

### 2、我们要安装串口函数库，终端执行下面的命令（如果使用的是官方镜像，应该是已经安装好了）：
```sudo pip3 install pyserial```

### 3、使用UART收发数据：
1 导入串口库 
```import serial as ser  ```
2 设置使用的引脚、波特率和超时时间
```se = ser.Serial("/dev/ttyTHS1", 9600, timeout=1)```
如果出现下面的错误：
```Serial Exception: [Errno 13] could not open port /dev/ttyTHS1: [Errno 13] Permission denied: '/dev/ttyTHS1'```
这是因为没有权限，使用下面的命令设置其权限为可读可写可执行
```sudo chmod 777 /dev/ttyTHS1```

### 3 使用write函数进行数据的发送（注意发送类型必须是字节，因此需要使用encode()函数进行转换）
```se.write("666".encode())```
decode()可以传入指定的编码名称来做指定编码，如：
```se.write("666".encode("GB2312"))```
或者直接在字符串前边加b:
```ser.write(b'hello')```
```如果你要用电脑USB转TTL接收数据：
1 安装USB转TTL驱动
2 安装串口调试助手
3 正确连线USB转TTL模块和板子
4 选择USB转TTL模块的正确串口，波特率和 2 中保持一致，数据位8，停止位1，无校验位。
5 打开串口，运行程序，得到数据显示。```

### 4 读取数据
读取指定长度使用：
```s = ser.read(100)```
100就是读取100个字符，你可以传入其他长度参数
读取一行（当读到 ‘\n’ 时，视当前读到的内容为一行。 ）
```line = ser.readline()```
读取的都是原始字节，需要用decode()函数进行解码进行输出：
```print(line.decode("GB2312"))```

### 5 串口状态
打开串口：
```ser.open()```
检测串口是否打开：
```ser.is_open```
返回值为True 或 False
串口关闭
```ser.close()```
检查串口是否关闭
```ser.is_open```
返回值为True 或 False
### 6 其他设置串口的写法
逐个设置：
```ser = serial.Serial()
ser.baudrate = 19200
ser.port = 'COM1'
ser.open()
ser.close()```
COM1就是上边2中的第一个参数
19200就是上边2中的第二个参数
上下文写法：
```serial.Serial() as ser:
    ser.baudrate = 19200
    ser.port = 'COM1'
    ser.open()
    ser.write(b'hello')```
COM需要调用open()，close()，UART不需要。
### 7 最后，官方文档：
https://pythonhosted.org/pyserial/shortintro.html#opening-serial-ports
### 8、最后附上我的测试代码及测试结果：
![avatar](https://img-blog.csdnimg.cn/20201224174941457.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDM1MDMzNw==,size_16,color_FFFFFF,t_70)
![avatar](https://img-blog.csdnimg.cn/20201224175817131.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDM1MDMzNw==,size_16,color_FFFFFF,t_70)
![avatar](https://img-blog.csdnimg.cn/20201224175806861.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDM1MDMzNw==,size_16,color_FFFFFF,t_70)