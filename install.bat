@shift /0
@shift /0
@echo off
set local enableextensions


Color 0F

set scriptpath=%~dp0
echo %scriptpath%

::Idea took from https://github.com/SlejmUr/Manifest_Tool_TB. Thanks for help https://github.com/SlejmUr.

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
goto timeout
::requirements check end

:timeout
Title Almost done...
cls
MODE 87,10
echo -------------------------------------------------------------------------------
echo If you have got a problem/issue, please report it back in our discord server.
echo Most of problems you meet are on user's side, so please make sure you're doing
echo everything right, so you don't waste your and our time.            
echo -------------------------------------------------------------------------------
echo.
timeout /T 10 >nul | echo 			Please wait 10 sec to continue^!
Resources\cmdMenuSel f870 "                                    Continue"
if %ERRORLEVEL% == 1 goto welcome

::welcome screen
:welcome
Title Looking for Minearea updates...
cls
MODE 81,10
echo -------------------------------------------------------------------------------
echo Downloader needs to check for updates first. Click the button below to start.
echo -------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "                                    Continue"
if %ERRORLEVEL% == 1 goto foldercheck
::welcome screen end

::check for updates
:foldercheck
Title Checking updates...1
if exist "%userprofile%\.minearea" (
goto createminecraft
) else (
    goto foldercreate
)

:foldercreate
Title Creating folder...
mkdir "%userprofile%\.minearea"
goto foldercheck

:minecraftcheck
Title Checking minecraft folder...
if exist "%appdata%\.minecraft" (
    goto getVer
) else (
    goto createminecraft
)

:createminecraft
Title Creating minecraft folder...
mkdir "%appdata%\.minecraft"
mkdir "%appdata%\.minecraft\mods"
mkdir "%appdata%\.minecraft\versions"
goto minecraftcheck

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
findstr /m "BYABCQAAAIIeSeH/b3KGAQ==" %userprofile%\.minearea\version.verify >Nul
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
call :colorEcho c0 "-------------------------------------------------------------------------------"
echo.
call :colorEcho c0 "  Your dowloader is outdated and it downloads wrong MC modpack. Please update."
echo.
call :colorEcho c0 "                             Redirecting you..."
echo.
call :colorEcho c0 "              Don't forget to delete outdated downloader folder."
echo. 
call :colorEcho c0 "-------------------------------------------------------------------------------"
timeout 5 >nul
start "" https://github.com/Rockstar234/MineareaUpdater/releases
exit 

:noupdatesfound
Title Verify complete
cls
echo -------------------------------------------------------------------------------
echo                        Your downloader is up to date.
echo -------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "                                    Continue"
if %ERRORLEVEL% == 1 goto mainmenu
::check for updates end

::main part
:mainmenu
Title Game Downloader
cls
MODE 87,17
echo -------------------------------------------------------------------------------
echo Welcome to Game Downloader menu. Current version is 1.0.3. If this version
echo doesn't match the version in discord, then click Update Client. If version is
echo fine and you need to update your game, then click Update Game. You can also come
echo back here after installation and check your version by clicking Version Check button.
echo -------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "  Install Game" "  Update Client" "  Discord Server" "  Exit"
if %ERRORLEVEL% == 1 goto installgame
if %ERRORLEVEL% == 2 goto updateclient
if %ERRORLEVEL% == 3 goto discordserver
if %ERRORLEVEL% == 4 goto closescript

:installgame
Title Installing client...
cls
MODE 79,20
echo -------------------------------------------------------------------------------
echo                        Trying to install your game...
echo        After success you need to select fabric loader in your MC launcher.
echo -------------------------------------------------------------------------------
curl -L  "https://download2263.mediafire.com/vsa8y3tmbw4g6dRdRc-0ewbX5EDONY4NDhkZ5OhCEVSYsAlVHtAaKc8_c3EQbiCwb4pu1ALpqIWY0H4nFz8gIcnOoorX1xDaxgfCdWaBW2Rk9EONUQr2mI7-074hsdB-GEDjyr_znvIi_e7lmqYEL3_Bc79OLkiL60ms-G-zTqyHiA/iny09htz5hyx08k/fabric-installer-0.11.2.jar" --ssl-no-revoke --output fabric-installer-0.11.2.jar
curl -L  "https://download1530.mediafire.com/uoyz6um1xnbg_96dmzt7PwosAKHjeQy9KVunfdeUb2m1q-ZQoEPdY44OvX2DjRUY0zrJd9MV4QwcuF6h_Qn1uTdQKpctmvJzq7QmGi4oNyw2sKrOl9clsgWIgH-cCedDD-WiholFZfZXMbbNz_VVuHecohenjVHpCdEdoyYPXmJxIw/hf7a3b0aqcix0yb/README.txt" --ssl-no-revoke --output README.txt
move /y README.txt Resources
curl -L  "https://download854.mediafire.com/q38y9fn2xxwgftsKdJ6XzjNvXS0LoLmotoujX33Hj8FexhGMzfqWYoAiIRWQh47pItBlHzF9EclLzq_l5fiK9_hkrKbmawAk2TUArdh9SktXrLLI3K_CIgijuCnqI-jlNc22_kd78XXJzNwUga1n9e1NGVxu5VHg518T-usGCT658g/8ef2ef4mmwtzqou/servers.dat" --ssl-no-revoke --output servers.dat
move /y servers.dat %appdata%\.minecraft
curl -L  "https://download1085.mediafire.com/6duwdxztw9bgJosukO3gURM7cwgPamREjpW6pZFD8L7OE8nCl8oZIFoQCV-oSowiaO7PGDU9rpijxV809PIj_FajLRaPDMAjmcFknQRL7eCzNDBnNtPAeenii2FR0bFZYH_I_f1aLYVQymBnchyuJpRWPiqYPx7Gebm7Sy-BEJhtkA/a5hobbrlhmz2l3n/fabric.7z" --ssl-no-revoke --output fabric.7z
for %%I in ("fabric.7z") do (
    "Resources\7z.exe" x -y -o"Resources\.minecraft" "%%I" -aoa && del %%I
    )
robocopy Resources\.minecraft %appdata%\.minecraft /E /MOVE
if exist "%appdata%\.minecraft\config\puzzle.json" (
    goto modsinstall
) else (
    goto somethingwentwrong
)

:discordserver
Title Discord Server
cls MODE 79,20
echo -------------------------------------------------------------------------------
echo               You're being redirected to our discord server.
echo                     You will be redirected in 5 seconds.
echo -------------------------------------------------------------------------------
timeout 5 >nul
start "" https://discord.gg/5GVb9UwsY7
Resources\cmdMenuSel f870 "  <- Back to Main Menu"
if %ERRORLEVEL% == 1 goto mainmenu

:updateclient
Title Update Client
cls MODE 79,20
echo -------------------------------------------------------------------------------
echo   You're being redirected to our github page to download latest version.
echo                     You will be redirected in 5 seconds.
echo                   Don't forget to delete outdated folder.
echo -------------------------------------------------------------------------------
timeout 5 >nul
start "" https://github.com/Rockstar234/MineareaUpdater/releases
exit
::later add automatic update. yes im crazy mf.

:closescript
Title GOODBYE!
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo                                    GOODBYE!
echo --------------------------------------------------------------------------------
timeout 2 >nul
exit
::main part end

:downloadcomplete
Title Update Complete
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo                             Download Complete!
echo --------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "                               Continue"
if %ERRORLEVEL% == 1 goto mainmenu

:somethingwentwrong
Title Something went wrong!
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo               Error! Something went wrong. Please report a problem.
echo --------------------------------------------------------------------------------
timeout 2 >nul
start "" https://github.com/Rockstar234/MineareaUpdater/issues
Resources\cmdMenuSel f870 "                               Continue"
if %ERRORLEVEL% == 1 goto mainmenu

:modsinstall
Title Client installed
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo     Your client is installed, but mods are missing. Launching update.bat...
echo   Your client is installed, but fabric-loader is missing. Launching java.bat...
echo     HINT: Click Update Game to install mods and then you can launch game.
echo --------------------------------------------------------------------------------
timeout 5 >nul
start update.bat
Powershell.exe -executionpolicy remotesigned -File  java.ps1
exit