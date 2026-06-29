@echo off
chcp 65001 > nul
setlocal enabledelayedexpansion
cd /d "%~dp0"

echo.
echo  -- RKMS Innovation - Git Push --
echo.

git status --short
echo.

REM Build file list from all changes (staged + unstaged)
set "FILELIST="
for /f "tokens=1*" %%a in ('git status --short') do (
    if "!FILELIST!"=="" (set "FILELIST=%%b") else (set "FILELIST=!FILELIST!, %%b")
)

if "!FILELIST!"=="" (
    echo  Nothing to commit.
    echo.
    pause & exit /b
)

echo  Suggested commit message:
echo.
echo    Update !FILELIST!
echo.
echo  Press Enter to use it, or type your own:
set /p MSG=  ^>
if "!MSG!"=="" set "MSG=Update !FILELIST!"

echo.
git add -A
git commit -m "!MSG!"
git push origin main

echo.
echo  Done!
echo.
pause
