# 方式一：[局域网连接-VNC]
VNC是可跨平台的远程桌面连接软件，可以解决嵌入式开发中屏幕连接的问题，也可以进行远程嵌入式设备开发管理维护。（VNC仅支持局域网连接，不过可以通过代理设置，进入局域网从而进行桌面连接）  
接下来对jetson nano的VNC配置进行说明：
### 1、jetson nano官方镜像中已安装有vnc软件vino-server，只需进行一些配置即可使用。如果没有就自己安装，安装命令如下：
```
sudo apt-get install vino-server
```
### 2、具体使用  
安装好后打开系统设置，找到桌面共享，点击没反应，然后会出现软件出错的提示，据说是个bug。  
解决方案：  
第一步：终端输入该命令  
```
sudo gedit /usr/share/glib-2.0/schemas/org.gnome.Vino.gschema.xml
```
第二步：在打开文件中添加下面的内容：
```
<key name='enabled' type='b'>
      <summary>Enable remote access to the desktop</summary>
      <description>
        If true, allows remote access to the desktop via the RFB
        protocol. Users on remote machines may then connect to the
        desktop using a VNC viewer.
      </description>
      <default>false</default>
</key>
```
注意添加位置为最后一个key标签的后面，如图，粘贴后保存：  
![avatar](https://img-blog.csdnimg.cn/20201222210619173.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDM1MDMzNw==,size_16,color_FFFFFF,t_70)
第三步：编译配置文件，执行以下命令：  
```
sudo glib-compile-schemas /usr/share/glib-2.0/schemas
```
这时候设置中的屏幕共享就可以打开了    
### 3、屏幕共享设置   
打开设置中的屏幕共享，进行如图所示配置，如果无需密码可以取消打钩对应项。
![avatar](https://img-blog.csdnimg.cn/20201222211751154.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDM1MDMzNw==,size_16,color_FFFFFF,t_70)
### 4、VNC配置、开启  
首先输入以下命令：  
```
cd  
sudo gedit ~/openvino
```
将以下内容粘贴到打开的文件中进去，然后保存并关闭：
```
#!/bin/bash
export DISPLAY=:0
gsettings set org.gnome.Vino enabled true
gsettings set org.gnome.Vino prompt-enabled false
gsettings set org.gnome.Vino require-encryption false
xrandr --fb 1280x720
/usr/lib/vino/vino-server &
```
打包成一个可执行的文件，执行下面的命令修改文件权限： 
```sudo chmod +x ~/openvino  ```
通过下面这一条命令启动vnc服务：
```~/openvino```
如果出现下面的错误就是你用HDMI线连接的屏幕所需的屏幕大小于上面设置的不一致，可以不用管它，没有关系：  
![avatar](https://img-blog.csdnimg.cn/20201222220412306.png)
如果觉得每次开机都要手动开启还是太麻烦，那么可以把它加入到开机启动项，这样一来每次开机就会自动开启vnc了。    
（1）点击桌面左上角第一个图标搜索“启动应用程序”，然后双击打开它.
![avatar](https://img-blog.csdnimg.cn/20201222213617944.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDM1MDMzNw==,size_16,color_FFFFFF,t_70)
（2）添加如下图所示内容，保存并退出：  
![avatar](https://img-blog.csdnimg.cn/20201222213919134.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDM1MDMzNw==,size_16,color_FFFFFF,t_70)
名字和注解可以随便写，主要用于标识开机启动项的。  
命令就是需要自启动的文件，可以使用右边的按钮找，就是刚刚创建的openvino文件。  
### 5、安装VNC软件进行桌面连接  
windows平台直接下载下面的软件进行安装：  
https://download.csdn.net/download/weixin_44350337/13758527  
安装时可以仅安装Viewer就可以实现远程连接jetson nano桌面。
![avatar](https://img-blog.csdnimg.cn/20201222212202386.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDM1MDMzNw==,size_16,color_FFFFFF,t_70)
最后可以点击创建桌面图标方便使用。  
![avatar](https://img-blog.csdnimg.cn/20201222212539925.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDM1MDMzNw==,size_16,color_FFFFFF,t_70)
其他平台请从下面的地址找对应版本：  
下载地址：https://www.realvnc.com/en/connect/download/viewer/  
### 6、打开软件并进行连接  
打开软件，输入jetson nano ip地址，点击连接，如有密码输入3中设置的密码。  
![avatar](https://img-blog.csdnimg.cn/20201222212636450.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDM1MDMzNw==,size_16,color_FFFFFF,t_70)
连接的画面大小是由四中的这条指令所控制的，如果你要修改界面大小请将1280x720改为其他你需要的大小（不要怀疑，乘号就是埃克斯）：
```xrandr --fb 1280x720```
因为界面是使用网络一行一行传过来的，所以网络和界面大小都会影响操作时延。
因为操作时延比较长所以只能做一些简单操作，不如JupyterLab用着舒服，但是Jupyter不能弹窗口。

# 方式二：[外网连接-Todesk/Teamviewer/向日葵]