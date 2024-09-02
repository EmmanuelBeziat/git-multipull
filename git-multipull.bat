@echo off
:: Enable delayed expansion to use variables inside loops
setlocal enabledelayedexpansion

:: Define ANSI escape codes for colors
set "RED=\033[0;31m"
set "GREEN=\033[0;32m"
set "YELLOW=\033[1;33m"
set "BLUE=\033[1;34m"
set "NC=\033[0m"  :: No Color (reset)

:: Counters for stats
set /A total=0
set /A success_count=0
set /A fail_count=0
set /A up_to_date_count=0
set /A skipped_count=0

:: Find all directories in the current directory
for /D %%d in (*) do (
    echo(
    echo [!NC!]Directory: !BLUE!%%d!NC!
    
    :: Check if the directory is a Git repository
    if exist "%%d\.git" (
        pushd "%%d" >nul
        echo !GREEN!Pulling latest changes...!NC!

        :: Perform git pull and capture output
        for /f "delims=" %%x in ('git pull 2^>^&1') do (
            set "output=%%x"
            echo !output!

            :: Check the output for specific phrases
            echo !output! | findstr /C:"Already up to date." >nul
            if !errorlevel! equ 0 (
                echo !YELLOW!Already up to date.!NC!
                set /A up_to_date_count+=1
            ) else (
                echo !output! | findstr /C:"Updating" >nul
                if !errorlevel! equ 0 (
                    echo !GREEN!Pull successful.!NC!
                    set /A success_count+=1
                ) else (
                    echo !RED!Pull failed.!NC!
                    set /A fail_count+=1
                )
            )
        )

        popd >nul
    ) else (
        echo !RED!Not a git repository. Skipping.!NC!
        set /A skipped_count+=1
    )
    set /A total+=1
)

:: Print the summary
echo(
echo !BLUE!All repositories checked over a total of !NC!%total%!BLUE! folders!NC!
echo !GREEN!Success: !NC!%success_count%
echo !YELLOW!Already up to date: !NC!%up_to_date_count%
echo !RED!Failed: !NC!%fail_count%
echo !RED!Skipped: !NC!%skipped_count%
