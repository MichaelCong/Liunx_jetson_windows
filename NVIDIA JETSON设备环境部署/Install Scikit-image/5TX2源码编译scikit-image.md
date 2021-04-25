文件  : 5TX2源码编译scikit-image.txt  
作者  : Michael Cong  
日期  : 2020/08/08  
邮箱  : rencong_jx@163.com  
# 参考链接  
https://pypi.org/project/scikit-image/
# 源码编译
```
$ git clone https://github.com/scikit-image/scikit-image
#Installation from source
#Install dependencies using:
$ pip install -r requirements.txt
#Then, install scikit-image using:
$ pip install .
#If you plan to develop the package, you may run it directly from source:
$ pip install -e .  # Do this once to add package to Python path
#Every time you modify Cython files, also run:
$ python setup.py build_ext -i  # Build binary extensions
```