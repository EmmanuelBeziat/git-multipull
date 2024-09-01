# Colors for output
$RED = "Red"
$GREEN = "Green"
$YELLOW = "Yellow"
$BLUE = "Blue"
$NC = "White"  # No Color (default)

# Counters for stats
$total = 0
$success_count = 0
$fail_count = 0
$up_to_date_count = 0
$skipped_count = 0

# Get all directories in the current directory
$dirs = Get-ChildItem -Directory -Name

foreach ($dir in $dirs) {
    Write-Host "Directory: $dir" -ForegroundColor $NC

    # Check if the directory is a Git repository
    if (Test-Path "$dir\.git") {
        Write-Host "Pulling latest changes..." -ForegroundColor $GREEN

        # Enter the directory and perform git pull
        Push-Location $dir
        $output = git pull 2>&1
        Write-Host $output

        if ($output -match "Already up to date.") {
            Write-Host "Already up to date." -ForegroundColor $YELLOW
            $up_to_date_count++
        } elseif ($LASTEXITCODE -eq 0) {
            Write-Host "Pull successful." -ForegroundColor $GREEN
            $success_count++
        } else {
            Write-Host "Pull failed." -ForegroundColor $RED
            $fail_count++
        }

        Pop-Location
    } else {
        Write-Host "Not a git repository. Skipping." -ForegroundColor $RED
        $skipped_count++
    }
    $total++
    Write-Host ""
}

# Print the summary
Write-Host "All repositories checked over a total of $total folders" -ForegroundColor $BLUE
Write-Host "Success: $success_count" -ForegroundColor $GREEN
Write-Host "Already up to date: $up_to_date_count" -ForegroundColor $YELLOW
Write-Host "Failed: $fail_count" -ForegroundColor $RED
Write-Host "Skipped: $skipped_count" -ForegroundColor $RED
