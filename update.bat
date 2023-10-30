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
goto gitCheck
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
echo ########################### Downloading git... ################################
echo -------------------------------------------------------------------------------
curl -L  "https://github.com/git-for-windows/git/releases/download/v2.41.0.windows.3/Git-2.41.0.3-64-bit.exe" --ssl-no-revoke --output Git-2.41.0.3-64-bit.exe
move Git-2.41.0.3-64-bit.exe Resources
goto timeout
::requirements check end

:timeout
Title Launching updater...
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
if exist "%appdata%\PrismLauncher\instances\1.19.2\.minecraft" (
    goto launcherprism
) else (
    goto prismcreate
)

:prismcreate
Title Creating Prism folders...
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
echo you need to update your game, then click Update Game. You can also come back
echo here after installation and check your version by clicking Version Check button.
echo -------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "  Update Game" "  Update Client" "  Discord Server" "  Exit"
if %ERRORLEVEL% == 1 goto updategame
if %ERRORLEVEL% == 2 goto updateclient
if %ERRORLEVEL% == 3 goto discordserver
if %ERRORLEVEL% == 4 goto closescript

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

:updategame
Title Updating game
cls
MODE 79,20
echo -------------------------------------------------------------------------------
echo                        Trying to update your game...
echo                Mods you had was moved to mods_backup folder.
echo -------------------------------------------------------------------------------
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.001" --ssl-no-revoke --output mods.7z.001
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.002" --ssl-no-revoke --output mods.7z.002
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.003" --ssl-no-revoke --output mods.7z.003
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.004" --ssl-no-revoke --output mods.7z.004
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.005" --ssl-no-revoke --output mods.7z.005
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.006" --ssl-no-revoke --output mods.7z.006
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.007" --ssl-no-revoke --output mods.7z.007
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.008" --ssl-no-revoke --output mods.7z.008
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.009" --ssl-no-revoke --output mods.7z.009
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.010" --ssl-no-revoke --output mods.7z.010
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.011" --ssl-no-revoke --output mods.7z.011
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.012" --ssl-no-revoke --output mods.7z.012
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.013" --ssl-no-revoke --output mods.7z.013
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.014" --ssl-no-revoke --output mods.7z.014
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.015" --ssl-no-revoke --output mods.7z.015
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.016" --ssl-no-revoke --output mods.7z.016
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.017" --ssl-no-revoke --output mods.7z.017
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.018" --ssl-no-revoke --output mods.7z.018
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.019" --ssl-no-revoke --output mods.7z.019
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.020" --ssl-no-revoke --output mods.7z.020
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.021" --ssl-no-revoke --output mods.7z.021
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.022" --ssl-no-revoke --output mods.7z.022
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.023" --ssl-no-revoke --output mods.7z.023
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.024" --ssl-no-revoke --output mods.7z.024
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.025" --ssl-no-revoke --output mods.7z.025
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.026" --ssl-no-revoke --output mods.7z.026
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.027" --ssl-no-revoke --output mods.7z.027
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/MineareaUpdater/mods/mods.7z.028" --ssl-no-revoke --output mods.7z.028
for %%I in ("mods.7z.001") do (
    "Resources\7z.exe" x -y -o"Resources\mods" "%%I" -aoa && del %%I
    )
mkdir %launcherpath%\mods_backup
robocopy %launcherpath%\mods %launcherpath%\mods_backup /E /MOVE
robocopy Resources\mods %launcherpath%\mods /E /MOVE
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
Resources\cmdMenuSel f870 "                               Continue"
if %ERRORLEVEL% == 1 goto mainmenu

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
