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
echo Updater needs to check for updates first. Click the button below to start.
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
call :colorEcho c0 "   Your updater is outdated and it downloads wrong MC modpack. Please update."
echo.
call :colorEcho c0 "                             Redirecting you..."
echo.
call :colorEcho c0 "               Don't forget to delete outdated updater folder."
echo. 
call :colorEcho c0 "-------------------------------------------------------------------------------"
timeout 5 >nul
start "" https://github.com/Rockstar234/MineareaUpdater/releases
exit 

::robocopy %userprofile%\Desktop\MineareaUpdater\Resources "%userprofile%\.minearea" verify.version /mt /z /is /it /im

:noupdatesfound
Title Verify complete
cls
echo -------------------------------------------------------------------------------
echo                        Your updater is up to date.
echo -------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "                                    Continue"
if %ERRORLEVEL% == 1 goto mainmenu
::check for updates end

::main part
:mainmenu
Title Game Updater
cls
MODE 87,17
echo -------------------------------------------------------------------------------
echo Welcome to Game Updater menu. Updater version is 1.0.3. If this version doesn't
echo match the version in discord, then click Update Client. If version is fine and
echo you need to update your game, then click Update Game. You can also come back
echo here after installation and check your version by clicking Version Check button.
echo -------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "  Update Client" "  Update Game" "  Discord Server" "  Exit"
if %ERRORLEVEL% == 1 goto updateclient
if %ERRORLEVEL% == 2 goto updategame
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
curl -L  "https://download1590.mediafire.com/kad582b3k9xgKuApmGhDIEHV5CL6FgQkfg2Eat1DBtSSsknMvDLMw3EcY5hFqaKeTPtd_g9z4d2vgOLNU4jRjpIbcspPfNirovAgb7r6C4WjH8HyVsBKXo1pe5L1W814FKCYedkGYqG22qE6JUCJsrjs7RBTD71SqMwx7H_SuXhC2w/ppneycmgedobbgv/mods.7z" --ssl-no-revoke --output mods.7z
for %%I in ("mods.7z") do (
    "Resources\7z.exe" x -y -o"Resources\mods" "%%I" -aoa && del %%I
    )
mkdir %appdata%\.minecraft\mods_backup
move /y %appdata%\.minecraft\mods %appdata%\.minecraft\mods_backup
move /y Resources\mods %appdata%\.minecraft
if exist "%appdata%\.minecraft\mods\Zoomify-2.9.0.jar" (
    goto updatecomplete
) else (
    goto somethingwentwrong
)

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

:updatecomplete
Title Update Complete
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo                              Update Complete!
echo --------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "                               Continue"
if %ERRORLEVEL% == 1 goto mainmenu

:somethingwentwrong
Title Something went wrong!
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo                      Error! Try again later or contact coder.
echo --------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "                               Continue"
if %ERRORLEVEL% == 1 goto mainmenu