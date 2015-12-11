# Git常用操作

## Windows使用git

### 连接远程仓库  
把用户目录下的.ssh里的公钥和密钥拷贝到git bash目录下的.ssh目录里就可以直接在cmd里用git了

windows下git push报Permission denied的解决方案
E:\Workspaces\hta\iReader&gt;git push origin master
Permission denied (publickey).
fatal: The remote end hung up unexpectedly
百般折腾，终于发现，只要在 git 附带的 bash （Git Bash 可以在开始菜单的 git 目标里面找到）里面运行命令，就可以一切正常。

$ ssh git@github.com
The authenticity of host 'github.com (207.97.227.239)' can't be established.
RSA key fingerprint is 16:27:ac:a5:76:28:2d:36:63:1b:56:4d:eb:df:a6:48.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'github.com,207.97.227.239' (RSA) to the list of kno
n hosts.
Hi greatghoul! You've successfully authenticated, but GitHub does not provide s
ell access.
Connection to github.com closed.

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
