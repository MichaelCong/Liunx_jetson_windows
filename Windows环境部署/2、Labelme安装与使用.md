https://blog.csdn.net/along1617188?t=1
https://blog.csdn.net/along1617188/article/details/100142787
Win10下安装labelme标注软件
Labelme介绍
在线图像标注工具，可做分割或者检测标注，使用方便，上手迅速。
Labelme 开源地址
https://github.com/CSAILVision/LabelMeAnnotationTool
Labelme 项目地址
http://labelme.csail.mit.edu/Release3.0/
Labelme  Python
https://github.com/wkentaro/labelme
Labelme  安装教程
https://blog.csdn.net/qq_21466543/article/details/80693955
Labelme安装（Win10）

创建Python下Labelme环境
默认已经安装了anaconda
创建环境
conda create -name=labelme python=3.7 //应该是自己的anaconda Python版本
conda activate labelme //激活以labelme为名称的labelme环境

安装pyqt
conda install pyqt  //系统会自动安装最新的pyqt5,所以安装Python2时到此步也许会报错
 
安装labelme
pip install labelme // 此处一般不会报错

启动labelme 
         打开Anaconda Prompt，打开labelme环境，输入labelme，即可使用软件。