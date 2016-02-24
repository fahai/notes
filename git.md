# Git常用操作

// TODO http://blog.jobbole.com/96088/?hmsr=toutiao.io&utm_medium=toutiao.io&utm_source=toutiao.io

## Git的常用命令  
1. 日志输出参数  

  命令示例  
> git log --oneline --graph  

  常用参数  
> –author=“Alex Kras” ——只显示某个用户的提交任务  
> –name-only ——只显示变更文件的名称  
> –oneline——将提交信息压缩到一行显示  
> –graph ——显示所有提交的依赖树  
> –reverse ——按照逆序显示提交记录（最先提交的在最前面）  
> –after ——显示某个日期之后发生的提交  
> –before ——显示发生某个日期之前的提交  

  更多用法  
> man git log  

2. 查看文件的详细变更  

  命令示例  
> git log -p filename    

  git log -p 或者 git log -p filename 不仅显示提交说明、提交者以及提交日期，还会显示这每次提交实际修改的内容。  
  然后你就可以使用 `less`中常用的检索命令即“斜杠”后面加检索词/{{在此处添加你的检索词}}），在变更内容日志中检索指定的关键词（使用小写的n跳到下一条检索结果，大写的N跳到上一条检索结果）。  

  更多用法  
> git log -p filename | less  

3. 查看文件中指定位置的变更  

  命令示例  
> git log -L 1,1:some-file.txt  

  可以使用 git blame filename 追查出文件中每一行是由谁变更的。  
  git blame 是一个非常强大的工具，但是又是无法提供足够的信息。  
  git log 提供了一个 -L 的选项。这个选项允许指定文件中的某些行。Git只会输出与这些行的变更日志。这有点像带焦点的 git log -p 。

  用法示例    
> git log -L 3,15:redis.md  
    查看redis.md文件第3行到15行的变更内容  

4. 查看尚未合并（merge）的变更  
查看其他分支中的文件
关于变更基线(rebase)的几点说明
本地合并之后保留分支结构
修复而非新建提交
的三种状态以及它们的相互转换
优雅地回退
使用第三方工具查看整个项目（而非单独文件）的变更
忽略空格变更
追加文件中的部分变更
发现并清理无用分支
暂存部分文件
如何写好提交信息
自动补全
创建常用命令的别名
快速定位问题版本


## Windows使用git

### 连接远程仓库  
把用户目录下的.ssh里的公钥和密钥拷贝到git bash目录下的.ssh目录里就可以直接在cmd里用git了

windows下git push报Permission denied的解决方案
E:\Workspaces\hta\iReader&gt;git push origin master
Permission denied (publickey).
fatal: The remote end hung up unexpectedly
百般折腾，终于发现，只要在 git 附带的 bash （Git Bash 可以在开始菜单的 git 目标里面找到）里面运行命令，就可以一切正常。

```  
$ ssh git@github.com
The authenticity of host 'github.com (207.97.227.239)' can't be established.
RSA key fingerprint is 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'github.com,207.97.227.239' (RSA) to the list of kno
n hosts.
Hi greatghoul! You've successfully authenticated, but GitHub does not provide s
ell access.
Connection to github.com closed.
```  

### Git fork project
- Create a new repository on the command line
```
echo # notes >> README.md
git init
git add README.md
git commit -m "first commit"
git remote add origin git@github.com:fahai/notes.git
git push -u origin master
```

- Push an existing repository from the command line
```
git remote add origin git@github.com:fahai/notes.git
git push -u origin master
```
