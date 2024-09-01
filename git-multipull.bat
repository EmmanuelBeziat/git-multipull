@echo off
:: Enable delayed expansion to use variables inside loops
setlocal enabledelayedexpansion

:: Define colors for output
set "RED=0C"
set "GREEN=0A"
set "YELLOW=0E"
set "BLUE=09"
set "NC=07"  :: Default color

:: Counters for stats
set /A total=0
set /A success_count=0
set /A fail_count=0
set /A up_to_date_count=0
set /A skipped_count=0

:: Find all directories in the current directory
for /D %%d in (*) do (
    echo(
    color !NC!
    echo Directory: [%%d]
    
    :: Check if the directory is a Git repository
    if exist "%%d\.git" (
        pushd "%%d" >nul
        color !GREEN!
        echo Pulling latest changes...

        :: Perform git pull and capture output
        for /f "delims=" %%x in ('git pull 2^>^&1') do (
            set "output=%%x"
            echo !output!

            :: Check the output for specific phrases
            if "!output!"=="Already up to date." (
                color !YELLOW!
                echo Already up to date.
                set /A up_to_date_count+=1
            ) else if "!output!"=="Updating" (
                color !GREEN!
                echo Pull successful.
                set /A success_count+=1
            ) else (
                color !RED!
                echo Pull failed.
                set /A fail_count+=1
            )
        )

        popd >nul
    ) else (
        color !RED!
        echo Not a git repository. Skipping.
        set /A skipped_count+=1
    )
    set /A total+=1
)

:: Print the summary
echo(
color !BLUE!
echo All repositories checked over a total of %total% folders
color !GREEN!
echo Success: %success_count%
color !YELLOW!
echo Already up to date: %up_to_date_count%
color !RED!
echo Failed: %fail_count%
color !RED!
echo Skipped: %skipped_count%
color !NC!
