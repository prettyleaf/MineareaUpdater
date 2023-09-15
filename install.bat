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
Title Launching installer...
cls
MODE 87,21
echo -------------------------------------------------------------------------------
echo       DO NOT RESIZE THIS WINDOW ESPECIALLY IF YOURE USING WINDOWS 11
echo.
echo If you have got a problem/issue, please report it back in our discord server.
echo Most of problems you meet are on user's side, so please make sure you're doing
echo everything right, so you don't waste your and our time.
echo.
echo       DO NOT RESIZE THIS WINDOW ESPECIALLY IF YOURE USING WINDOWS 11
echo -------------------------------------------------------------------------------
echo.
timeout /T 10 >nul | echo 			Please wait 10 sec to continue^!
Resources\cmdMenuSel f870 "                                    Continue"
if %ERRORLEVEL% == 1 goto foldercheck

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
::BYAxCQAAAMIaDcXL/sVGCeMC old
::BYABCQAAAIIeSdL/byLjaA== new
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
echo                        Your downloader is up to date.
echo -------------------------------------------------------------------------------
timeout 2 >nul
goto welcome
::check for updates end

::welcome screen
:welcome
Title Select one of options...
cls
MODE 87,17
echo -------------------------------------------------------------------------------
echo                         What launcher do you use?
echo -------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "  Minecraft Launcher" "  PrismLauncher (not portable)" "  TLauncher" "  CurseForge (work in progress)" "  Not listed here"
if %ERRORLEVEL% == 1 goto minecraftcheck
if %ERRORLEVEL% == 2 goto prismcheck
if %ERRORLEVEL% == 3 goto tlaunchercheck
if %ERRORLEVEL% == 4 goto launchercurseforge
if %ERRORLEVEL% == 5 goto notlistedcheck

:launcherminecraft
Title Minecraft Launcher was selected as default launcher...
cls
MODE 81,10
set launcherpath=%appdata%\.minecraft
goto mainmenu

:minecraftcheck
Title Checking minecraft folder...
if exist "%appdata%\.minecraft" (
    goto launcherminecraft
) else (
    goto createminecraft
)

:createminecraft
Title Creating minecraft folder...
mkdir "%appdata%\.minecraft"
mkdir "%appdata%\.minecraft\mods"
mkdir "%appdata%\.minecraft\versions"
goto minecraftcheck

:launcherprism
Title PrismLauncher was selected as default launcher...
cls
MODE 81,10
set launcherpath=%appdata%\PrismLauncher\instances\1.19.2\.minecraft
goto mainmenu

:prismcheck
Title Checking Prism folders...
if exist "%appdata%\PrismLauncher\instances\1.19.2\.minecraft" (
    goto launcherprism
) else (
    goto prismcreate
)

:prismcreate
Title Creating Prism folders...
mkdir "%appdata%\PrismLauncher\instances"
mkdir "%appdata%\PrismLauncher\instances\1.19.2"
mkdir "%appdata%\PrismLauncher\instances\1.19.2\.minecraft"
goto prismcheck

:launchertlauncher
Title TLauncher was selected as default launcher...
cls
MODE 81,10
set launcherpath=%appdata%\.minecraft
goto mainmenu

:tlaunchercheck
Title Checking minecraft folder...
if exist "%appdata%\.minecraft\mods" (
    goto launchertlauncher
) else (
    goto createtlauncher
)

:createtlauncher
Title Creating minecraft folder...
mkdir "%appdata%\.minecraft"
mkdir "%appdata%\.minecraft\mods"
mkdir "%appdata%\.minecraft\versions"
goto tlaunchercheck

:launchercurseforge
Title Minecraft Launcher was selected as default launcher...
cls
MODE 81,10
mkdir "%userprofile%\curseforge\minecraft\Instances\BetterMC+Modified+by+Rockstar234"
mkdir "%userprofile%\curseforge\minecraft\Instances\BetterMC+Modified+by+Rockstar234\mods"
mkdir "%userprofile%\curseforge\minecraft\Instances\BetterMC+Modified+by+Rockstar234\profileImage"
curl -L  "https://download847.mediafire.com/dwrzzdg6ladgs-53j1V5jdkXRZn_7S3QTwUHGm57La0yRqhuRjlO8LsWbmVXsfdpeaD29SaFEHy2Cuj9eQyhykWJxVWB1ODdoOVSn4wdkwbmT7ckV3CrZRimdJBPl1yVUX94wwGgG5mx-vvLG92f0C-WSkVoX-WlQlQVqrVSGTev/51p3udy0qni2ci7/minearea2k20_avatar.jpg" --ssl-no-revoke --output minearea2k20_avatar.jpg
move /y minearea2k20_avatar.jpg %userprofile%\curseforge\minecraft\Instances\BetterMC+Modified+by+Rockstar234\profileImage
set launcherpath=%userprofile%\curseforge\minecraft\Instances\BetterMC+Modified+by+Rockstar234
goto mainmenu

:launchernotlisted
Title Default launcher settings were selected...
cls
MODE 81,10
set launcherpath=%appdata%\.minecraft
goto mainmenu

:notlistedcheck
Title Checking minecraft folder...
if exist "%appdata%\.minecraft" (
    goto launchernotlisted
) else (
    goto createnotlisted
)

:createnotlisted
Title Creating minecraft folder...
mkdir "%appdata%\.minecraft"
mkdir "%appdata%\.minecraft\mods"
mkdir "%appdata%\.minecraft\versions"
goto notlistedcheck
::welcome screen end

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
Resources\cmdMenuSel f870 "  Install Game" "  Install Fabric" "  Update Client" "  Discord Server" "  Exit"
if %ERRORLEVEL% == 1 goto installgame
if %ERRORLEVEL% == 2 goto fabricinstall
if %ERRORLEVEL% == 3 goto updateclient
if %ERRORLEVEL% == 4 goto discordserver
if %ERRORLEVEL% == 5 goto closescript

:installgame
Title Installing client...
cls
MODE 79,20
echo -------------------------------------------------------------------------------
echo                        Trying to install your game...
echo        After success you need to select fabric loader in your MC launcher.
echo -------------------------------------------------------------------------------
curl -L  "https://download2263.mediafire.com/oze20nked03gxrEnselCB5p64omjN-xqlAW1yrh7aBdhMoK2KCC9iKOCz5WmgWbDCWH0TevaqnMJqQko3RsH64IEtPUrqWzvsP1R69FuqWk3CjfvbB8SedjbGoCU-zwBF3VfyPL0BYitIN2oA6beZdBe3bNbw79a1hbj_ygvb0yp/iny09htz5hyx08k/fabric-installer-0.11.2.jar" --ssl-no-revoke --output fabric-installer-0.11.2.jar
curl -L  "https://download854.mediafire.com/p9yjqecnmvog-2QQf3lEAgRQoIuzKEnhvkZS7GDnrkiZxEVmPxPMngQw5JmjzVOWm7ddVhR6_yKaCnpTCL4z3W76ANfT5U1Rf7y0gxsGmxzU9HhNfeL6XCmwNSuqrdRYjHgihNmt32TkbU2VYBfSZJjuvAuFrWg_eniEpQTamO1I/8ef2ef4mmwtzqou/servers.dat" --ssl-no-revoke --output servers.dat
move /y servers.dat %launcherpath%
curl -L  "https://download1503.mediafire.com/649m73u5gi2gcHLodxHsVmhp-EqOqy4P3_RhnIz4ArquwjGxT_XC1ffcoI3My47MinNAxDQE3uKBOTYONNJPdaKqnfYCSpa0EpIYfdujrBhSJRLlWBUd5OjTEtdY7k7vu__pqDpsLxWxBKJRUV5Uoc3gJZFrEOxkvzgMmz964foG/a5hobbrlhmz2l3n/fabric.7z" --ssl-no-revoke --output fabric.7z
for %%I in ("fabric.7z") do (
    "Resources\7z.exe" x -y -o"Resources\.minecraft" "%%I" -aoa && del %%I
    )
robocopy Resources\.minecraft %launcherpath% /E /MOVE
if exist "%launcherpath%\config\puzzle.json" (
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
timeout 3 >nul
exit

:somethingwentwrong
Title Something went wrong!
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo               Error! Something went wrong. Please report a problem.
echo --------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "                               Continue" "                            Report an issue"
if %ERRORLEVEL% == 1 goto mainmenu
if %ERRORLEVEL% == 2 goto reportissue

:reportissue
start "" https://github.com/Rockstar234/MineareaUpdater/issues
goto mainmenu

:modsinstall
Title Client installed
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo     Your client is installed, but mods are missing. Launching update.bat...
echo     HINT: Click Update Game to install mods and then you can launch game.
echo --------------------------------------------------------------------------------
timeout 5 >nul
start update.bat
goto fabricinstall

:fabricinstall
Title Fabric client install
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo       You also need to install fabric, so you can launch the game.
echo  I'll try to do it myself, but if you see error when launch fabric.jar yourself.
echo     Also UNCHECK Create profile inside it and select 1.19.2 game version.
echo If you're using PrismLauncher, CurseForge or Not Listed launcher skip this
echo because you install fabric by using your launcher.
echo --------------------------------------------------------------------------------
curl -L  "https://download2263.mediafire.com/oze20nked03gxrEnselCB5p64omjN-xqlAW1yrh7aBdhMoK2KCC9iKOCz5WmgWbDCWH0TevaqnMJqQko3RsH64IEtPUrqWzvsP1R69FuqWk3CjfvbB8SedjbGoCU-zwBF3VfyPL0BYitIN2oA6beZdBe3bNbw79a1hbj_ygvb0yp/iny09htz5hyx08k/fabric-installer-0.11.2.jar" --ssl-no-revoke --output fabric-installer-0.11.2.jar
Powershell.exe -executionpolicy remotesigned -File  java.ps1
if exist "%appdata%\.minecraft\versions\fabric-loader-0.14.21-1.19.2\fabric-loader-0.14.21-1.19.2.jar" (
    goto downloadcomplete
) else (
    goto somethingwentwrong
    start fabric-installer-0.11.2.jar
)
