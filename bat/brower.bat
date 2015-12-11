rem brower.bat
rem Program:
rem 	接收1个参数，跳转到对应的SVN路径;
rem 	如果没有参数，显示SVN地址栏;
rem 	如果多于1个参数，提示参数过多;
rem 	如果1个参数匹配不上，提示没有此类型的参数;

@echo off
cd d:\Program Files\TortoiseSVN\bin\
if "%2%"=="" (
	if "%1%"=="zhoubao" (
		start TortoiseProc.exe /command:repobrowser /path:"http://10.116.50.190/svn/ccsdd/周报/
	)else if "%1%"=="temp" (
		start TortoiseProc.exe /command:repobrowser /path:"http://10.116.50.190/svn/upgrade-new/Temp/ESG-CCS5/V1.0/
	)else if "%1%"=="" (
		start TortoiseProc.exe /command:repobrowser
	)else (
		echo "No such params, try: zhoubao, temp or no params"
		pause
	)
)else (
	echo "too much params"
	pause
)
