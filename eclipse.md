Eclipse  
---  


## 反编译插件JadClipse
jad: 一个将.calss文件反编译成.java源文件的工具
  http://varaneckas.com/jad/

JadClipse: Eclipse plugins
  http://sourceforge.net/projects/jadclipse/

Install:
  Download jad files;
  copy jad %JAVA_HOME%/bin;
  Download jadclipse files;
  copy net.sf.jadclipse_3.3.0.jar %ECLIPSE_HOME%/plugins
  Open Eclipse: Windows->Preferences->Java->JadClipse
    "path to decompiler" : %JAVA_HOME%/bin/jad
  Windowns->Preference->General->Editor->File Associations
    ".class" default "JadClipse Class File Viewer"
  Done

## SVN插件  
http://www.cnblogs.com/ruiati/p/3584120.html  
How to use

## 更改编辑器字体大小
1.更改java文件大小设置
Window->preferences->General->Appearance->Colors   and   Fonts->
Java->Java Editor Text Font->右边按钮Change
英文版默认的是Courier New 常规 10
2.更改jsp文件大小设置
Window->preferences->General->Appearance->Colors   and   Fonts->
Basic->TextFont->右边按钮Change


About keys
	Preference - search "key" - Content Assist

About comment
	Windows-->Preference-->Java-->Code Style-->Code Templates

About code setting


## Others  
Q: 在接口的方法添加@Override注解报编译期的错误  
A：编译期的错误一般都是项目的编译器版本不合适，版本过低或者其他原因。查看Project的属性，选择"Java Compiler"，选择合适的Compiler即可解决问题。
