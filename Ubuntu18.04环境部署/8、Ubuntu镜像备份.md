#  #制作ubuntu系统镜像
网上的教程有很多，最好用的就是Systemback这个软件，通过控制台就能安装。  
但是如果你是ubuntu18.04以后的系统，按照教程的步骤执行，一定会遇到这个问题：  
The repository 'http://ppa.launchpad.net/nemh/systemback/ubuntu bionic Release' does not have a Release file.  
这是由于Systemback的作者在2016年停止了开发，因此Ubuntu 18.04和18.10不在支持列表中。  
针对ubuntu18.04以后的系统，我们只需要依次执行以下命令：  
1.如果你已经添加过PPA，请先删除（否则忽略此步）：  
sudo add-apt-repository --remove ppa:nemh/systemback  
2.重新添加PPA：  
sudo add-apt-repository "deb http://ppa.launchpad.net/nemh/systemback/ubuntu xenial main"  
3.更新包列表并安装Systemback：  
sudo apt update  
sudo apt install systemback  
安装完成后就可以从应用程序菜单启动Systemback，需要输入密码：  
![](https://pic1.zhimg.com/80/v2-cfbca94c5307dbb5446826ef90d4cfa4_1440w.jpg) 
打开后软件如下：  
![](https://pic1.zhimg.com/80/v2-7dfacf96ad9c4d8675773909cde32940_1440w.jpg) 
点击右侧的Live system create按钮，出现界面如下：  
![](https://pic2.zhimg.com/80/v2-22d7169355ada51be8368c95a618b289_1440w.jpg)  
勾选左侧的include the user data files，这样自己主文件夹内的文件都会被包含在系统镜像中。    
点击Create New按钮就开始创建了，等待创建完成。完成后界面如下：  
![](https://pic3.zhimg.com/80/v2-58e9a4b70ce01c795818c98c52d4fc66_1440w.jpg)
右侧的列表中就是已经创建的备份。图中已经创建了两个相关的备份，所以有两个在右侧显示。此时文件没有转换成iso格式，选中你要转换的备份，点击convert to ISO 。转换完成后，在设定好的工作目录下就能找到生成的iso文件。整个流程在15分钟左右。  
以上为iso文件小于4g时可用，当iso大于4g时需要用另一种方式来convert to iso：  
具体步骤请参考链接：  
解决systemback 无法生成超过4G的iso的问题  [https://link.zhihu.com/?target=http%3A//community.bwbot.org/topic/194/%25E8%25A7%25A3%25E5%2586%25B3systemback-%25E6%2597%25A0%25E6%25B3%2595%25E7%2594%259F%25E6%2588%2590%25E8%25B6%2585%25E8%25BF%25874g%25E7%259A%2584iso%25E7%259A%2584%25E9%2597%25AE%25E9%25A2%2598](https://link.zhihu.com/?target=http%3A//community.bwbot.org/topic/194/%25E8%25A7%25A3%25E5%2586%25B3systemback-%25E6%2597%25A0%25E6%25B3%2595%25E7%2594%259F%25E6%2588%2590%25E8%25B6%2585%25E8%25BF%25874g%25E7%259A%2584iso%25E7%259A%2584%25E9%2597%25AE%25E9%25A2%2598)