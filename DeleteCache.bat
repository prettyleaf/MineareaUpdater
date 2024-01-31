@shift /0
@shift /0
@echo off
set local enableextensions


Color 0F

set scriptpath=%~dp0
echo %scriptpath%
chcp 437 > nul

goto getVer


:getVer
Title Checking updates...
cls 
MODE 79,20
echo -------------------------------------------------------------------------------
echo ######################## Trying to verify version... ##########################
echo -------------------------------------------------------------------------------
curl -L  "https://github.com/Rockstar234/RequirementsForScripts/raw/main/Cleaner/cleaner.verify" --ssl-no-revoke --output cleaner.verify
move cleaner.verify %userprofile%\.minearea
goto versioncheck 

:versioncheck
Title Checking updates...
findstr /m "BYAhEQAACMQykYEkiDnuxfcXu30udAQ=" %userprofile%\.minearea\cleaner.verify >Nul
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
echo                    Cleaner is outdated. Please update.
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
echo ###################### Your cleaner is up to date. #########################
echo -------------------------------------------------------------------------------
timeout 2 >nul
goto cacheClear

:cacheClear
Title Clearing cache...
cls
MODE 87,10
echo --------------------------------------------------------------------------------
echo ###################### Please, wait. Clearing cache... #########################
echo --------------------------------------------------------------------------------
timeout 2 >nul
cd %userprofile%\.minearea\temp

del * /S /Q

rmdir /S /Q "%userprofile%\.minearea\temp"
cls
echo Operation succeeded.
timeout 1 >nul
