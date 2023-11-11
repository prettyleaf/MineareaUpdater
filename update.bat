@shift /0
@shift /0
@echo off
set local enableextensions


Color 0F

set scriptpath=%~dp0
echo %scriptpath%
chcp 437 > nul

::Idea took from https://github.com/SlejmUr/Manifest_Tool_TB.
::Credits 
::https://github.com/SlejmUr
::JVAV

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
echo ###########################  Downloading 7-Zip... #############################
echo -------------------------------------------------------------------------------
curl.exe -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/7z.exe" --ssl-no-revoke --output 7z.exe
move 7z.exe Resources
goto 7zipcheck

:cmdCheck
if exist "Resources\cmdmenusel.exe" (
goto java17Check
) else (
goto GetCmd
)
goto cmdCheck

:GetCmd
cls
MODE 79,20
echo -------------------------------------------------------------------------------
echo ########################### Downloading cmdmenusel... #########################
echo -------------------------------------------------------------------------------
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/cmdmenusel.exe" --ssl-no-revoke --output cmdmenusel.exe
move cmdmenusel.exe Resources
goto cmdCheck

:java17Check
if exist "C:\Program Files\Java\jdk-17\bin\java.exe" (
goto foldercheck
) else (
goto javaWarning
)

:javaWarning
cls
MODE 79,20
echo -------------------------------------------------------------------------------
echo ########################### Java 17 is missing! ###############################
echo ########## You can install/update Java in main menu. Redirecting... ###########
echo -------------------------------------------------------------------------------
timeout /T 3 >nul
goto foldercheck
::requirements check end

::check for updates
:foldercheck
Title Checking updates...1
if exist "%userprofile%\.minearea\temp" (
goto getVer
) else (
    goto foldercreate
)

:foldercreate
Title Creating folder...
mkdir "%userprofile%\.minearea"
mkdir "%userprofile%\.minearea\temp"
goto foldercheck

:getVer
Title Checking updates...2
cls 
MODE 79,20
echo -------------------------------------------------------------------------------
echo ######################## Trying to verify version... ##########################
echo -------------------------------------------------------------------------------
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/version.verify" --ssl-no-revoke --output version.verify
move version.verify %userprofile%\.minearea
goto versioncheck 

:versioncheck
Title Checking updates...3
::BYABCQAAAIIeSdL/byLjaA== 103
::BYABCQAAAIIeSYH/t8kZBg== 104
findstr /m "BYABCQAAAIIeSYH/t8kZBg==" %userprofile%\.minearea\version.verify >Nul
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
echo ###################### Your downloader is up to date. #########################
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
echo ########################## What launcher do you use? ##########################
echo -------------------------------------------------------------------------------
echo *Means this option is recommended
echo **Means not portable version and recommended
echo ***Means work in progress
echo. 
Resources\cmdMenuSel f870 "  Minecraft Launcher" "  **PrismLauncher" "  TLauncher" "  CurseForge" "  Not listed here"
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
if exist "%appdata%\.minecraft\mods" (
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
findstr /m "BYABCQAAAIIeSYH/t8kZBg==" %appdata%\PrismLauncher\instances\1.19.2\check.verify >Nul
if %errorlevel%==0 (
goto launcherprism
)

if %errorlevel%==1 (
goto prismcreate
)

:prismcreate
Title Creating Prism folders...
mkdir "%appdata%\PrismLauncher\instances"
mkdir "%appdata%\PrismLauncher\icons"
mkdir "%appdata%\PrismLauncher\instances\1.19.2"
mkdir "%appdata%\PrismLauncher\instances\1.19.2\.minecraft"
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/prismlauncher/instance.cfg" --ssl-no-revoke --output instance.cfg
move /y instance.cfg %appdata%\PrismLauncher\instances\1.19.2
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/prismlauncher/mmc-pack.json" --ssl-no-revoke --output mmc-pack.json
move /y mmc-pack.json %appdata%\PrismLauncher\instances\1.19.2
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/main/MineareaUpdater/prismlauncher/minearea2k20_avatar.jpg" --ssl-no-revoke --output minearea2k20_avatar.jpg
move /y minearea2k20_avatar.jpg %appdata%\PrismLauncher\icons
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/prismlauncher/check.verify" --ssl-no-revoke --output check.verify
move /y check.verify %appdata%\PrismLauncher\instances\1.19.2
goto prismcheck

:launchertlauncher
Title TLauncher was selected as default launcher...
cls
MODE 81,10
set launcherpath=%appdata%\.minecraft
goto mainmenu

:tlaunchercheck
Title Checking minecraft folder...
if exist "%appdata%\.minecraft" (
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
curl -L  "https://raw.githubusercontent.com/Rockstar234/RequirementsForScripts/main/MineareaUpdater/minearea2k20_avatar.jpg" --ssl-no-revoke --output minearea2k20_avatar.jpg
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
Title Game Updater
cls
MODE 87,17
echo -------------------------------------------------------------------------------
echo Welcome to Game Updater menu. Updater version is 1.0.4. If this version doesn't
echo match the version in discord, then click Update Client. If version is fine and
echo you need to update your game, then click Update Mods. You can also update
echo game files, configs and etc by clicking Install Game button.
echo -------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "  Update Mods" "  Launch Game" "  Update Launcher" "  Discord Server" "  Exit"
if %ERRORLEVEL% == 1 goto updategame
if %ERRORLEVEL% == 2 goto launchgame
if %ERRORLEVEL% == 3 goto updatelauncher
if %ERRORLEVEL% == 4 goto discordserver
if %ERRORLEVEL% == 5 goto closescript

:launchgame
Title Game Launcher
cls
MODE 81,17
echo -------------------------------------------------------------------------------
echo #                     What launcher you want to launch?                       #
echo -------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "  PrismLauncher" "  TLauncher" "  Soon" "  <- Back to Main Menu"
if %ERRORLEVEL% == 1 goto launchprism
if %ERRORLEVEL% == 2 goto launchtlauncher
if %ERRORLEVEL% == 3 goto mainmenu
if %ERRORLEVEL% == 4 goto mainmenu

:launchprism
Title Launching game...
cls
MODE 81,17
echo -------------------------------------------------------------------------------
echo #                         Game is launching... Wait...                       #
echo -------------------------------------------------------------------------------
start %localappdata%\Programs\PrismLauncher\prismlauncher.exe --launch 1.19.2
exit

:launchtlauncher
Title Launching game...
cls
MODE 81,17
echo -------------------------------------------------------------------------------
echo #                         Game is launching... Wait...                       #
echo -------------------------------------------------------------------------------
start %appdata%\.minecraft\tlauncher.exe --version fabric-loader-0.14.21-1.19.2
exit

:discordserver
Title Discord Server
cls MODE 79,20
echo -------------------------------------------------------------------------------
echo #              You're being redirected to our discord server.                 #
echo #                    You will be redirected in 5 seconds.                     #
echo -------------------------------------------------------------------------------
timeout 5 >nul
start "" https://discord.gg/5GVb9UwsY7
Resources\cmdMenuSel f870 "  <- Back to Main Menu"
if %ERRORLEVEL% == 1 goto mainmenu

:updatelauncher
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

:updategame
Title Updating game
cls
MODE 79,20
echo -------------------------------------------------------------------------------
echo                        Trying to update your game...
echo                Mods you had was moved to mods_backup folder.
echo -------------------------------------------------------------------------------
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.001" --ssl-no-revoke --output mods.7z.001
cls
echo Downloading... (1/28)
echo.
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.002" --ssl-no-revoke --output mods.7z.002
cls
echo Downloading... (2/28)
echo.
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.003" --ssl-no-revoke --output mods.7z.003
cls
echo Downloading... (3/28)
echo.
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.004" --ssl-no-revoke --output mods.7z.004
cls
echo Downloading... (4/28)
echo.
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.005" --ssl-no-revoke --output mods.7z.005
cls
echo Downloading... (5/28)
echo.
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.006" --ssl-no-revoke --output mods.7z.006
cls
echo Downloading... (6/28)
echo.
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.007" --ssl-no-revoke --output mods.7z.007
cls
echo Downloading... (7/28)
echo.
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.008" --ssl-no-revoke --output mods.7z.008
cls
echo Downloading... (8/28)
echo.
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.009" --ssl-no-revoke --output mods.7z.009
cls
echo Downloading... (9/28)
echo.
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.010" --ssl-no-revoke --output mods.7z.010
cls
echo Downloading... (10/28)
echo.
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.011" --ssl-no-revoke --output mods.7z.011
cls
echo Downloading... (11/28)
echo.
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.012" --ssl-no-revoke --output mods.7z.012
cls
echo Downloading... (12/28)
echo.
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.013" --ssl-no-revoke --output mods.7z.013
cls
echo Downloading... (13/28)
echo.
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.014" --ssl-no-revoke --output mods.7z.014
cls
echo Downloading... (14/28)
echo.
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.015" --ssl-no-revoke --output mods.7z.015
cls
echo Downloading... (15/28)
echo.
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.016" --ssl-no-revoke --output mods.7z.016
cls
echo Downloading... (16/28)
echo.
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.017" --ssl-no-revoke --output mods.7z.017
cls
echo Downloading... (17/28)
echo.
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.018" --ssl-no-revoke --output mods.7z.018
cls
echo Downloading... (18/28)
echo.
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.019" --ssl-no-revoke --output mods.7z.019
cls
echo Downloading... (19/28)
echo.
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.020" --ssl-no-revoke --output mods.7z.020
cls
echo Downloading... (20/28)
echo.
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.021" --ssl-no-revoke --output mods.7z.021
cls
echo Downloading... (21/28)
echo.
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.022" --ssl-no-revoke --output mods.7z.022
cls
echo Downloading... (22/28)
echo.
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.023" --ssl-no-revoke --output mods.7z.023
cls
echo Downloading... (23/28)
echo.
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.024" --ssl-no-revoke --output mods.7z.024
cls
echo Downloading... (24/28)
echo.
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.025" --ssl-no-revoke --output mods.7z.025
cls
echo Downloading... (25/28)
echo.
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.026" --ssl-no-revoke --output mods.7z.026
cls
echo Downloading... (26/28)
echo.
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.027" --ssl-no-revoke --output mods.7z.027
cls
echo Downloading... (27/28)
echo.
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.028" --ssl-no-revoke --output mods.7z.028
for %%I in ("mods.7z.001") do (
    "Resources\7z.exe" x -y -o"Resources\mods" "%%I" -aoa && del %%I
    )
mkdir %launcherpath%\mods_backup
robocopy %launcherpath%\mods %launcherpath%\mods_backup /E /MOVE
robocopy Resources\mods %launcherpath%\mods /E /MOVE
move /y mods.7z.001 %userprofile%\.minearea\temp
move /y mods.7z.002 %userprofile%\.minearea\temp
move /y mods.7z.003 %userprofile%\.minearea\temp
move /y mods.7z.004 %userprofile%\.minearea\temp
move /y mods.7z.005 %userprofile%\.minearea\temp
move /y mods.7z.006 %userprofile%\.minearea\temp
move /y mods.7z.007 %userprofile%\.minearea\temp
move /y mods.7z.008 %userprofile%\.minearea\temp
move /y mods.7z.009 %userprofile%\.minearea\temp
move /y mods.7z.010 %userprofile%\.minearea\temp
move /y mods.7z.011 %userprofile%\.minearea\temp
move /y mods.7z.012 %userprofile%\.minearea\temp
move /y mods.7z.013 %userprofile%\.minearea\temp
move /y mods.7z.014 %userprofile%\.minearea\temp
move /y mods.7z.015 %userprofile%\.minearea\temp
move /y mods.7z.016 %userprofile%\.minearea\temp
move /y mods.7z.017 %userprofile%\.minearea\temp
move /y mods.7z.018 %userprofile%\.minearea\temp
move /y mods.7z.019 %userprofile%\.minearea\temp
move /y mods.7z.020 %userprofile%\.minearea\temp
move /y mods.7z.021 %userprofile%\.minearea\temp
move /y mods.7z.022 %userprofile%\.minearea\temp
move /y mods.7z.023 %userprofile%\.minearea\temp
move /y mods.7z.024 %userprofile%\.minearea\temp
move /y mods.7z.025 %userprofile%\.minearea\temp
move /y mods.7z.026 %userprofile%\.minearea\temp
move /y mods.7z.027 %userprofile%\.minearea\temp
move /y mods.7z.028 %userprofile%\.minearea\temp
if exist "%launcherpath%\mods\Zoomify-2.9.0.jar" (
    goto updatecomplete
) else (
    goto somethingwentwrong
)

:closescript
Title GOODBYE!
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo ################################# GOODBYE! #####################################
echo --------------------------------------------------------------------------------
timeout 2 >nul
exit
::main part end

:updatecomplete
Title Update Complete
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo ############################# Update Complete! #################################
echo --------------------------------------------------------------------------------
timeout 2 >nul
goto mainmenu

:somethingwentwrong
Title Something went wrong!
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo ##### Woops! Something went wrong and gives an error. Please report back. #####
echo --------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "                               Continue" "                            Report an issue"
if %ERRORLEVEL% == 1 goto mainmenu
if %ERRORLEVEL% == 2 goto reportissue

:reportissue
start "" https://github.com/Rockstar234/MineareaUpdater/issues
goto mainmenu
