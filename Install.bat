@echo off
:: Get the current script directory
set "batchPath=%~dp0"
:: Change directory to script location
cd /d "%batchPath%"

:: Delete all files in the Rime AppData directory
del "%AppData%\Rime\*.*" /Q
:: Remove opencc directory
rmdir "%AppData%\Rime\opencc" /S /Q
:: Copy custom files to the RIME folder
xcopy ".\Rime\*.*" /S "%AppData%\Rime\"

:: Find the installed Weasel version dynamically
set "WeaselPath="
for /d %%V in ("C:\Program Files\Rime\weasel-*") do set "WeaselPath=%%V"
if not "%WeaselPath%"=="" (
    if exist "%WeaselPath%\WeaselDeployer.exe" (
        "%WeaselPath%\WeaselDeployer.exe" /deploy
        echo Restart Weasel
        pause
        exit
    )
)

set "WeaselPath="
for /d %%V in ("C:\Program Files (x86)\Rime\weasel-*") do set "WeaselPath=%%V"
if not "%WeaselPath%"=="" (
    if exist "%WeaselPath%\WeaselDeployer.exe" (
        "%WeaselPath%\WeaselDeployer.exe" /deploy
        echo Restart Weasel
        pause
        exit
    )
)

:: If no version was found
echo Can't find Weasel
pause

