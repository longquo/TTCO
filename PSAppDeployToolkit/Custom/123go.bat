REM "Long Truong ©"
REM Oct 2020
@ECHO off

:MENU
cls
color 0A
ECHO %cd%
ECHO. 
ECHO.   Deployment CHOOSER %~n0                        
ECHO. #------------------------------------------------#
ECHO. # 0 - Repair                                     #
ECHO. # 1 - Silent_Install                             #
ECHO. # 2 - Silent_Uninstall                           #
ECHO. # 3 - Interactive_Install                        #
ECHO. # 4 - Interactive_Uninstall                      #
ECHO. #------------------------------------------------#
ECHO. # e - Explorer current path                      #
ECHO. # o - Open log dir                               #
ECHO. # f - Flush log                                  #
ECHO. #------------------------------------------------#
ECHO. # x - EXIT                                       #
ECHO. #------------------------------------------------#
ECHO.
SET /P Choice=Menu Choose:

set "TIME="

IF %Choice%==0 GOTO Repair
IF %Choice%==1 GOTO Silent_Install
IF %Choice%==2 GOTO Silent_Uninstall
IF %Choice%==3 GOTO Interactive_Install
IF %Choice%==4 GOTO Interactive_Uninstall
IF %Choice%==e GOTO Explorer
IF %Choice%==o GOTO OpenLOG
IF %Choice%==f GOTO FlushLOG
IF %Choice%==x GOTO EOF
cls
echo Choice: '%Choice%' is not valid option
ping localhost -n 2 >Nul
pause
CLS
GOTO MENU

REM #####################################################################################################################
:Repair
cls
color 06
ECHO. ### Repair ###
ECHO %cd%
set "Start=%TIME%"
"%~dp0Deploy-Application.exe" "Deploy-Application.ps1" -DeploymentType "Repair" -DeployMode "Silent"
set "End=%TIME%"
call :timediff Elapsed Start End
color 0C
echo Elapsed Time: %Elapsed%
pause
GOTO MENU
REM #####################################################################################################################
:Silent_Install
cls
color 06
ECHO. ### SILENT INSTALL ###
ECHO %cd%
set "Start=%TIME%"
"%~dp0Deploy-Application.exe" "Deploy-Application.ps1" -DeploymentType "Install" -DeployMode "Silent"
set "End=%TIME%"
call :timediff Elapsed Start End
color 0C
echo Elapsed Time: %Elapsed%
pause
GOTO MENU
REM #####################################################################################################################
:Silent_Uninstall
cls
color 06
ECHO. ### SILENT UNINSTALL ###
ECHO %cd%
set "Start=%TIME%"
"%~dp0Deploy-Application.exe" "Deploy-Application.ps1" -DeploymentType "Uninstall" -DeployMode "Silent"
set "End=%TIME%"
call :timediff Elapsed Start End
color 0C
echo Elapsed Time: %Elapsed%
pause
GOTO MENU
REM #####################################################################################################################
:Interactive_Install
cls
color 06
ECHO. ### INTERACTIVE INSTALL ###
ECHO %cd%
set "Start=%TIME%"
"%~dp0Deploy-Application.exe" "Deploy-Application.ps1" -DeploymentType "Install" -DeployMode "Interactive"
set "End=%TIME%"
call :timediff Elapsed Start End
color 0C
echo Elapsed Time: %Elapsed%
pause
GOTO MENU
REM #####################################################################################################################
:Interactive_Uninstall
cls
color 06
ECHO. ### INTERACTIVE UNINSTALL ###
ECHO %cd%
set "Start=%TIME%"
"%~dp0Deploy-Application.exe" "Deploy-Application.ps1" -DeploymentType "Uninstall" -DeployMode "Interactive"
set "End=%TIME%"
call :timediff Elapsed Start End
color 0C
echo Elapsed Time: %Elapsed%
pause
GOTO MENU
REM #####################################################################################################################
:OpenLog
IF EXIST %windir%\Logs\Software\NUL (
    %SystemRoot%\explorer.exe %windir%\Logs\Software
    GOTO MENU
    ) Else (
        IF EXIST "C:\Program Files\RMCM\Logs\NUL" (
            %SystemRoot%\explorer.exe "C:\Program Files\RMCM\Logs\"
            GOTO MENU
        )  
    )
GOTO MENU
REM #####################################################################################################################
:FlushLOG
IF EXIST %windir%\Logs\Software\NUL (
    del "%windir%\Logs\Software\*.*" /Q
    pause
    GOTO MENU
    ) Else (
        IF EXIST "C:\Program Files\RMCM\Logs\" (
            del "C:\Program Files\RMCM\Logs\*.*" /Q
            pause
            GOTO MENU
        )  
    )
pause
GOTO MENU
REM #####################################################################################################################
:Explorer
start . "%~dp0"
pause
GOTO MENU
REM #####################################################################################################################



REM #####################################################################################################################
:timediff <outDiff> <inStartTime> <inEndTime>
(
    setlocal EnableDelayedExpansion
    set "Input=!%~2! !%~3!"
    for /F "tokens=1,3 delims=0123456789 " %%A in ("!Input!") do set "time.delims=%%A%%B "
)
for /F "tokens=1-8 delims=%time.delims%" %%a in ("%Input%") do (
    for %%A in ("@h1=%%a" "@m1=%%b" "@s1=%%c" "@c1=%%d" "@h2=%%e" "@m2=%%f" "@s2=%%g" "@c2=%%h") do (
        for /F "tokens=1,2 delims==" %%A in ("%%~A") do (
            for /F "tokens=* delims=0" %%B in ("%%B") do set "%%A=%%B"
        )
    )
    set /a "@d=(@h2-@h1)*360000+(@m2-@m1)*6000+(@s2-@s1)*100+(@c2-@c1), @sign=((@d&0x80000000)>>31)&1, @d+=(@sign*24*360000), @h=(@d/360000), @d%%=360000, @m=@d/6000, @d%%=6000, @s=@d/100, @c=@d%%100"
)
(
    if /i %@h% LEQ 9 set "@h=0%@h%"
    if /i %@m% LEQ 9 set "@m=0%@m%"
    if /i %@s% LEQ 9 set "@s=0%@s%"
    if /i %@c% LEQ 9 set "@c=0%@c%"
)
(
    endlocal
    set "%~1=%@h%%time.delims:~0,1%%@m%%time.delims:~0,1%%@s%%time.delims:~1,1%%@c%"
    exit /b
)
REM #####################################################################################################################

:EOF
exit
