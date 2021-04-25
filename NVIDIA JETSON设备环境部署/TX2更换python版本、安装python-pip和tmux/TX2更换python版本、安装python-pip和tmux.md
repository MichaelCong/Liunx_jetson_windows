文件  : 2TX2更换python版本、安装python-pip和tmux.txt  
作者  : Michael Cong  
日期  : 2020/08/08  
邮箱  : rencong_jx@163.com  
参考链接：https://forums.developer.nvidia.com/t/pytorch-for-jetson-nano-version-1-5-0-now-available/72048  
## 1 修改python版本
给Jetson TX2刷机之后，运行python默认是python2，而我们用python3多一些，因此用以下方法更改一下  
首先运行以下代码  
```
sudo update-alternatives --install /usr/bin/python python /usr/bin/python2 100
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 150
```
把两个版本的python加入到alternatives列表中，然后运行以下代码配置
```
sudo update-alternatives --config python
```
根据提示来选择要使用的版本，选择后退出，运行python即可看到默认python版本发生变化  
## 2 TX2安装pip工具
```
sudo apt install python-pip
sudo apt install python3-pip
```
安装pip之后如果pip的版本低，则可以使用以下命令进行更新升级：
```
sudo python -m pip install --upgrade pip
# python -m ensurepip
# python -m pip install --upgrade pip
```
## 3 开启最大功耗模式
```
sudo nvpmodel -q verbose
sudo nvpmodel -m 0 
```

## 4 安装tmux工具
我们在linux服务器上的工作一般都是通过一个远程的终端连接软件连接到远端系统进行操作，
例如使用xshell或者SecureCRT工具通过ssh进行远程连接。在使用过程中，如果要做比较耗时的操作，
例如有时候进行编译，或者下载大文件需要比较长的时间，一般情况下是下班之后直接运行希望第二
天早上过来运行完成，这样就不用耽误工作时间。但是网络有时候不稳定，可能在半夜会出现连接断
掉的情况，一旦连接断掉，我们所执行的程序也就中断，我们当然可以写一个脚本后台运行，但是
还是不方便。那么有没有一种工具可以解决这样的问题呢。这就是我们这里要提到的tmux了。  
其实类似tmux的工具还有很多。例如gnu screen等。tmux刚好可以解决我们描述的问题，
当我们在tmux中工作的时候，即使关掉SecureCRT的连接窗口，再次连接，进入tmux的会话我们
之前的工作仍然在继续。  
tmux中有3种概念，会话，窗口(window)，窗格(pane)。会话有点像是tmux的服务，在后端运行，
我们可以通过tmux命令创建这种服务，并且可以通过tmux命令查看，附加到后端运行的会话中。
一个会话可以包含多个窗口，一个窗口可以被分割成多个窗格(pane)。  
（1） tmux的安装方法很简单，可直接通过apt安装： 
```sudo apt-get install tmux```   
（2）新建会话
```tmux new -s [会话名]  ```  
（3）退出会话：```ctrl+b d```    
（4）查看会话列表：```tmux ls```    
如果是在某个会话环境中想查看会话列表，可以用以下指令来获得，然后用键盘选择就可进入：ctrl+b s  
（5）进入会话：```tmux a -t [会话名] ```   
（6）销毁会话：```tmux kill-session -t [会话名]```   
（7）重命名会话：```tmux rename -t [旧会话名] [新会话名]```  
（8）窗口操作：
```
一个tmux的会话中可以有多个窗口(window)，每个窗口又可以分割成多个pane(窗格)。    
我们工作的最小单位其实是窗格。默认情况下在一个window中，只有一个大窗格，占满整个窗口区域。我们在这个区域工作。
```  
（9）新建窗口：```ctrl+b c```。默认情况下创建出来的窗口由窗口序号+窗口名字组成，窗口名字可以由上面提到的方法修改，可以看到新创建的窗口后面有*号，表示是当前窗口。  
（10）切换窗口：在同一个会话的多个窗口之间可以通过如下快捷键进行切换：```ctrl+b p (previous的首字母) ```切换到上一个window。  
```ctrl+b n (next的首字母) ```切换到下一个window。```ctrl+b 0``` 切换到0号window，依次类推，可换成任意窗口序号  
```ctrl+b w``` (windows的首字母) 列出当前session所有window，通过上、下键切换窗口  
```ctrl+b l``` (字母L的小写)相邻的window切换  
（11）关闭窗口：```ctrl+b & ``` 
（12）窗格：tmux的一个窗口可以被分成多个pane(窗格)，可以做出分屏的效果。  
（13）垂直分屏：```ctrl+b % ``` 
（14）水平分屏：```ctrl+b " ``` 
（15）切换窗格：```ctrl+b o``` 依次切换当前窗口下的各个pane。    
```ctrl+b Up|Down|Left|Right``` 根据按箭方向选择切换到某个pane。  
```ctrl+b Space``` (空格键) 对当前窗口下的所有pane重新排列布局，每按一次，换一种样式。  
```ctrl+b z``` 最大化当前pane。再按一次后恢复。   
（16）关闭窗格：```ctrl+b x``` 关闭当前使用中的pane，操作之后会给出是否关闭的提示，按y确认即关闭。  
 