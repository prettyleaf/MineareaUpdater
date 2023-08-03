@shift /0
@shift /0
@echo off
set local enableextensions


Color 0F

set scriptpath=%~dp0
echo %scriptpath%

::Idea took from https://github.com/SlejmUr/Manifest_Tool_TB. Thanks for help https://github.com/SlejmUr.

:killexplorer
taskkill /f /im explorer.exe
goto 7zipcheck

::requirements check
:7zipcheck
MODE 62,50
if exist "Resources\7z.exe" (
goto cmdCheck
) else (
mkdir Resources
goto no7zip
)
goto 7zipcheck

:no7zip
cls
MODE 79,20
echo -------------------------------------------------------------------------------
echo                       Downloading 7-Zip...
echo -------------------------------------------------------------------------------
curl.exe -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/7z.exe" --ssl-no-revoke --output 7z.exe
move 7z.exe Resources
goto 7zipcheck

:cmdCheck
if exist "Resources\cmdmenusel.exe" (
goto gitCheck
) else (
goto GetCmd
)
goto cmdCheck

:GetCmd
cls
MODE 79,20
echo -------------------------------------------------------------------------------
echo                        Downloading cmdmenusel...
echo -------------------------------------------------------------------------------
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/cmdmenusel.exe" --ssl-no-revoke --output cmdmenusel.exe
move cmdmenusel.exe Resources
goto cmdCheck

:gitCheck
if exist "Resources\Git-2.41.0.3-64-bit.exe" (
goto timeout
) else (
goto getGit
)
goto gitCheck

:getGit
cls
MODE 79,20
echo -------------------------------------------------------------------------------
echo                        Downloading git...
echo -------------------------------------------------------------------------------
curl -L  "https://github.com/git-for-windows/git/releases/download/v2.41.0.windows.3/Git-2.41.0.3-64-bit.exe" --ssl-no-revoke --output Git-2.41.0.3-64-bit.exe
move Git-2.41.0.3-64-bit.exe Resources
goto welcome
::requirements check end

::welcome screen
:welcome
Title Looking for Minearea updates...
cls
MODE 81,10
echo -------------------------------------------------------------------------------
echo Tool needs to check for updates first. Click the button below to start.
echo -------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "                                    Continue"
if %ERRORLEVEL% == 1 goto foldercheck
::welcome screen end

::check for updates
:foldercheck
Title Checking updates...1
if exist "%userprofile%\.minearea" (
goto getVer
) else (
    goto foldercreate
)

:foldercreate
Title Creating folder...
mkdir "%userprofile%\.minearea"
goto foldercheck

:getVer
Title Checking updates...2
cls 
MODE 79,20
echo -------------------------------------------------------------------------------
echo                        Trying to verify version...
echo -------------------------------------------------------------------------------
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/version.verify" --ssl-no-revoke --output version.verify
move version.verify %userprofile%\.minearea
goto versioncheck 

:versioncheck
Title Checking updates...3
findstr /m "BYABCQAAAIIeSdL/byLjaA==" %userprofile%\.minearea\version.verify >Nul
if %errorlevel%==0 (
goto noupdatesfound
)

if %errorlevel%==1 (
goto updatesfound
)

:updatesfound
Title Checking updates...4
cls
MODE 87,17
echo -------------------------------------------------------------------------------
echo  Your dowloader is outdated and it downloads wrong MC modpack. Please update.
echo                             Redirecting you...
echo              Don't forget to delete outdated downloader folder.
echo -------------------------------------------------------------------------------
timeout 5 >nul
start "" https://github.com/Rockstar234/MineareaUpdater/releases
exit  

:noupdatesfound
Title Verify complete
cls
echo -------------------------------------------------------------------------------
echo                        Your tool is up to date.
echo -------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "                                    Continue"
if %ERRORLEVEL% == 1 goto mainmenu
::check for updates end

::mainmenu
:mainmenu
Title Main Menu
cls
MODE 87,17
echo -------------------------------------------------------------------------------
echo
echo     Welcome to server control panel. It's for advanced users only, so if you're
echo new it's better to read a wiki first. If you're running this tool for the first
echo time, then click Quick-setup button. This tool can't hurt your system until
echo you've read the wiki, so please do it before starting.
echo
echo                       Coded by @Rockstar234 for MineArea.
echo -------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "  Quick-setup" "  Server controls" "  Developer mode" "  Wiki"
if %ERRORLEVEL% == 1 goto quicksetup1
if %ERRORLEVEL% == 2 goto servercontrols
if %ERRORLEVEL% == 3 goto devmode
if %ERRORLEVEL% == 4 goto wiki

::quicksetup
:quicksetup1
Title Quick-setup
cls
MODE 87,10
echo -------------------------------------------------------------------------------
echo Creating a startup file... (1/4)
echo -------------------------------------------------------------------------------
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"

echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\MineareaTool.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%scriptpath%\host.bat" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%

cscript /nologo %SCRIPT%
del %SCRIPT%

:quicksetup2
Title Quick-setup
cls
MODE 87,10
echo -------------------------------------------------------------------------------
echo Startup check... (2/4)
echo -------------------------------------------------------------------------------
timeout 2 >nul
if exist "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\MineareaTool.lnk" (
    goto quicksetup3
) else (
    goto somethingwentwrong
)

:quicksetup3
Title Quick-setup
cls
MODE 87,10
echo -------------------------------------------------------------------------------
echo part 3 here
echo -------------------------------------------------------------------------------
goto quicksetup4

:quicksetup4
Title Quick-setup
cls
MODE 87,10
echo -------------------------------------------------------------------------------
echo part 4 here
echo -------------------------------------------------------------------------------
goto quickesetup_success
::quicksetup end

::servercontrols
:servercontrols
Title Server Controls
cls
MODE 87,21
call :colorEcho c0 "-------------------------------------------------------------------------------"
echo.
call :colorEcho c0 "Make sure your server folder is located at desktop and named as"
echo.
call :colorEcho c0 "BMC1_Fabric_1.19.2_Server_Pack"
echo.
call :colorEcho c0 "-------------------------------------------------------------------------------"
echo.
echo
echo -------------------------------------------------------------------------------
echo What do we want to do?
echo -------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "  Start server" "  Save and stop server (safe)" "  Critical shutdown (not safe)" "  Quick-commands"
if %ERRORLEVEL% == 1 goto startserver
if %ERRORLEVEL% == 2 goto safestop
if %ERRORLEVEL% == 3 goto notsafestop
if %ERRORLEVEL% == 4 goto quickcommands

:startserver

:safestop

:notsafestop
Title Stopping server by using unsafe method...
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo Stopping server...
echo --------------------------------------------------------------------------------
taskkill /f /im powershell.exe
timeout 3 >nul
cls
echo --------------------------------------------------------------------------------
echo Server was stopped. It was painful to do.
echo --------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "  Back to Controls"
if %ERRORLEVEL% == 1 goto servercontrols

:quickcommands

::servercontrols end

::devmode
:devmode
::devmode end

::wiki
:wiki
::wiki end

::mainmenu end

::extras
:quickesetup_success
Title Successful installation.
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo Server control panel is successfully installed and ready to work.
echo Do you want to restart system now?
echo --------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "  Yes." "  No, I'll do it later."
if %ERRORLEVEL% == 1 goto restartingsystem
if %ERRORLEVEL% == 2 goto mainmenu

:somethingwentwrong
Title Something went wrong!
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo                      Error! Try again later or contact coder.
echo --------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "                               Continue"
if %ERRORLEVEL% == 1 goto mainmenu

:restartingsystem
Title Restarting machine...
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo Restarting your system in 5 seconds...
echo --------------------------------------------------------------------------------
timeout 4 >nul
shutdown /r /t 1
::extras end