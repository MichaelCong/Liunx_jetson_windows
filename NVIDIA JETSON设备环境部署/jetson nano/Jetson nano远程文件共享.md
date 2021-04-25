Samba服务能够实现同一局域网下电脑对Jetson nano的文件共享
### 1、将Jetson nano正常启动并连接网络
### 2、更新并安装Samba
```sudo apt-get update 
sudo apt-get install samba -y```
如果你刚刚已经更新过 apt-get 使用第二条命令直接安装即可。

### 3、在用户目录创建共享文件夹sambashare
```cd 
mkdir sambashare```
sambashare 是共享文件夹的名称，你可以设置你喜欢的名称以及你想要的存储位置，只要是个文件夹就可。

### 4、配置文件。 修改/etc/samba/smb.conf
```sudo vi /etc/samba/smb.conf```
拉到文件的最后，将下面的语句添加到文件尾部  
```[sambashare]
   comment = Samba on JetsonNano
   path = /home/username/sambashare
   read only = no
   browsable = yes```
注意：这里的username需要改成你的系统的用户名。也就是说path是你要设置的共享文件夹路径。  
添加完成之后保存退出  

### 5、重启Samba服务  
```sudo service smbd restart```
应用配置  

### 6、设置共享文件夹密码  
```sudo smbpasswd -a username```
注意：这里的username需要改成你系统的用户名，如果不是用户名就会失败。  
这里会要求设置Samba密码，建议是直接用你的系统的密码，比较方便记忆  

### 7、设置完成之后，在你的电脑端，打开文件管理器（打开一个文件夹就好了）
windows系统：  
在导航栏输入  
```\\ip_address\sambashare```
就可以打开共享文件夹，进行文件操作了  
注意：这里的ip_address是你的jetson nano的当前Ip地址

windows系统会弹出连接凭证如下，用户名和密码是第6步中设置的用户名和密码，点击记住凭证后确认就可以在文件管理器中看到共享文件夹了。
![avatar](https://img-blog.csdnimg.cn/20201221213743924.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDM1MDMzNw==,size_16,color_FFFFFF,t_70)
仅输入IP就可以显示该ip下的所有共享文件夹，也就是说共享文件夹可以设置多个：
![avatar](https://img-blog.csdnimg.cn/20201222162352723.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDM1MDMzNw==,size_16,color_FFFFFF,t_70)

ubuntu和mac连接方式如下：
![avatar](https://img-blog.csdnimg.cn/20201221214245800.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3dlaXhpbl80NDM1MDMzNw==,size_16,color_FFFFFF,t_70)