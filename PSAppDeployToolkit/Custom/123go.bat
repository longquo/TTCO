REM "Long Truong <lontru@rm.dk>"

ECHO off

:MENU
CLS
color 0A
ECHO.
ECHO +------------------------------------------------+
ECHO ¦ Deployment CHOOSER                             ¦
ECHO ¦ Version: 1.0.0.0                               ¦
ECHO ¦------------------------------------------------¦
ECHO ¦------------------------------------------------¦
ECHO ¦ 1 - Silent_Install                             ¦
ECHO ¦ 2 - Silent_Uninstall                           ¦
ECHO ¦ 3 - Interactive_Install                        ¦
ECHO ¦ 4 - Interactive_Uninstall                      ¦
ECHO ¦------------------------------------------------¦
ECHO ¦ x - EXIT                                       ¦
ECHO +------------------------------------------------+
SET /P Choice=Menu Choose:
set domain=onerm

IF %Choice%==1 GOTO Silent_Install
IF %Choice%==2 GOTO Silent_Uninstall
IF %Choice%==3 GOTO Interactive_Install
IF %Choice%==4 GOTO Interactive_Uninstall
IF %Choice%==x GOTO EOF

:Silent_Install
REM Silent Install
cls
Echo "Silent Install"
ECHO ¦------------------------------------------------¦
"%~dp0TimeMem-1.0.exe" "%~dp0Deploy-Application.exe" "Deploy-Application.ps1" -DeploymentType "Install" -DeployMode "Silent"
ECHO ¦------------------------------------------------¦
pause
GOTO MENU

:Silent_Uninstall
REM Silent Uninstall
cls
Echo "Silent Uninstall"
ECHO ¦------------------------------------------------¦
"%~dp0TimeMem-1.0.exe" "%~dp0Deploy-Application.exe" "Deploy-Application.ps1" -DeploymentType "Uninstall" -DeployMode "Silent"
ECHO ¦------------------------------------------------¦
pause
GOTO MENU

:Interactive_Install
REM Interactive Install
cls
Echo "Interactive Install"
ECHO ¦------------------------------------------------¦
"%~dp0TimeMem-1.0.exe" "%~dp0Deploy-Application.exe" "Deploy-Application.ps1" -DeploymentType "Install" -DeployMode "Interactive"
ECHO ¦------------------------------------------------¦
pause
GOTO MENU

:Interactive_Uninstall
REM Interactive Uninstall
cls
Echo "Interactive Uninstall"
ECHO ¦------------------------------------------------¦
"%~dp0TimeMem-1.0.exe" "%~dp0Deploy-Application.exe" "Deploy-Application.ps1" -DeploymentType "Uninstall" -DeployMode "Interactive"
ECHO ¦------------------------------------------------¦
pause
GOTO MENU

EOF
exit