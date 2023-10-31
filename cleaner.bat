@shift /0
@shift /0
@echo off
set local enableextensions


Color 0F

set scriptpath=%~dp0
echo %scriptpath%
chcp 437 > nul

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
goto foldercheck
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
::requirements check end

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
echo ##### Your cleaner is outdated and it may hurt MC modpack. Please update. #####
echo ############################# Redirecting you... ##############################
echo ################# Don't forget to delete outdated folder. #####################
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
goto cleaner
::check for updates end

::main part
:cleaner
Title Cleaner
cls
MODE 87,17
echo -------------------------------------------------------------------------------
echo ############ Are you sure you want to start cleaning process? #################
echo -------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "  Yes" "  No" "  More info"
if %ERRORLEVEL% == 1 goto selectionyes
if %ERRORLEVEL% == 2 goto selectionno
if %ERRORLEVEL% == 3 goto moreinfo
::main part end

:selectionyes
Title Cleaning my files...
cls
MODE 87,10
del /F /Q %scriptpath%\mods.7z.016
rmdir /S /Q "%scriptpath%\flex\"
if exist "%scriptpath%\mods.7z.016" (
    goto operationcomplete
) else (
    goto operationfailed
)

:selectionno
cls
MODE 87,10
goto closescript

:closescript
Title GOODBYE!
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo ################################# GOODBYE! #####################################
echo --------------------------------------------------------------------------------
timeout 2 >nul
exit

:moreinfo
cls
MODE 87,10
echo -------------------------------------------------------------------------------
echo This script deletes all temporary files like 7z files and etc.
echo If you use an outdated cleaner your  PC and MC modpack may get hurt.
echo Make sure your cleaner is right next to other files (innstaller, updater)
echo -------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "  Ok."
if %ERRORLEVEL% == 1 goto cleaner

:operationcomplete
Title Update Complete
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo ########################### Operation Complete! ################################
echo --------------------------------------------------------------------------------
timeout 3 >nul
exit

:operationfailed
Title Something went wrong!
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo ################# Woops! Operation failed! Please report back. #################
echo --------------------------------------------------------------------------------
Resources\cmdMenuSel f870 "                               Continue" "                            Report an issue"
if %ERRORLEVEL% == 1 goto cleaner
if %ERRORLEVEL% == 2 goto reportissue

:reportissue
start "" https://github.com/Rockstar234/MineareaUpdater/issues
goto cleaner