#!/bin/bash

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
NC='\033[0m' # No Color

# Counters for stats
total=0
success_count=0
fail_count=0
up_to_date_count=0
skipped_count=0

# Find all directories in the current directory
dirs=$(find . -mindepth 1 -maxdepth 1 -type d -name "[^.]*")

for dir in $dirs; do
    echo -e "${NC}Directory: ${BLUE}${dir}${NC}"

    # Enter directory and perform git pull
    if [ -d "$dir/.git" ]; then
        cd "$dir"
        echo -e "${GREEN}Pulling latest changes...${NC}"
        output=$(git pull 2>&1)
        if echo "$output" | grep -q "Already up to date."; then
            echo -e "${YELLOW}Already up to date.${NC}\n"
            ((up_to_date_count++))
        elif [ $? -eq 0 ]; then
            echo -e "${GREEN}Pull successful.${NC}\n"
            ((success_count++))
        else
            echo -e "${RED}Pull failed.${NC}\n"
            ((fail_count++))
        fi
        cd - > /dev/null
    else
        echo -e "${RED}Not a git repository. Skipping.${NC}\n"
		((skipped_count++))
    fi
	((total++))
done

# Print the summary
echo -e "${BLUE}All repositories checked over a total of ${NC}${total}${BLUE} folders${NC}"
echo -e "${GREEN}Success:${NC} ${success_count}"
echo -e "${YELLOW}Already up to date:${NC} ${up_to_date_count}"
echo -e "${RED}Failed:${NC} ${fail_count}"
echo -e "${RED}Skipped:${NC} ${fail_count}"
