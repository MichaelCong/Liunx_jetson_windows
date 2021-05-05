@文件  : 使用git命令行将本地仓库代码上传到github或gitlab远程仓库.txt
@作者  : Michael Cong
@日期  : 2020/09/03
@邮箱  : rencong_jx@163.com
本地创建了一个 xcode 工程项目，现通过 命令行 将该项目上传到 github 或者 gitlab 远程仓库，具体操作流程如下：
# 第1步：建立本地 git 仓库，cd 到你的本地项目根目录下，执行 git init 命令
cd 本地工程根目录
git init  //这个目录就变成了git可以管理的仓库
# 第2步：将本地项目工作区的所有文件添加到暂存区。
小数点 “.” ，意为添加文件夹下的所有文件；也可以将 “.” 换成具体的文件名，如果想添加项目中的指定文件，那就把 “.” 改为指定文件名即可
git add .
# 第3步：将暂存区的文件提交到本地仓库
git commit -m "注释说明"
github 上创建 repo
然后复制一下远程仓库的https地址，如下所示：
github 仓库地址
# 第5步：将本地代码仓库关联到 github 上
git remote add origin https://github.com/MichaelCong/ubuntu-and-TX2-setting.git
"https://github.com/MichaelCong/ubuntu-and-TX2-setting.git" 就是我在第四步时复制的那个https地址
在这一步时如果出现错误：
fatal:remote origin already exists
那就先输入
git remote rm origin
再输入
 git remote add origin https://github.com/MichaelCong/ubuntu-and-TX2-setting.git
就不会报错了。
# 第6步：将代码由本地仓库上传到 github 远程仓库，依次执行下列语句
6-1、 获取远程库与本地同步合并（如果远程库不为空必须做这一步，否则后面的提交会失败）：
git pull --rebase origin master  //不加这句可能报错，原因是 github 中的 README.md 文件不在本地仓库中
//可以通过该命令进行代码合并
6-2、 把当前分支 master 推送到远程，执行此命令后有可能会让输入用户名、密码：
git push -u origin master  //执行完之后如果无错误就上传成功了，需要提示的是这里的 master 是 github 默认的分支，
//如果你本地的当前分支不是 master，就用git checkout master命令切换到master分支，
//如果你想用本地当前分支上传代码，则把第6步的命令里的 master 切换成你的当前分支名即可。
至此，操作成功！

git 常用命令：http://www.ruanyifeng.com/blog/2015/12/git-cheat-sheet.html

git init 
git add .
git commit -m "rencong"
git remote add origin https://gitlab.com/MichaelCong/darknet_yolov4_rencong.git
git pull --rebase origin master --allow-unrelated-histories
git push -u origin master 
#git push --force https://gitlab.com/MichaelCong/darknet_yolov4_rencong.git