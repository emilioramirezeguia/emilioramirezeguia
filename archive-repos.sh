#!/bin/bash

# GitHub Repository Archiver Script
# This script archives multiple GitHub repositories using the GitHub CLI
# Usage: ./archive-repos.sh

# Color codes for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Owner username
OWNER="emilioramirezeguia"

# Arrays of repositories to archive by category
declare -a CATEGORY_1=(
    "Array-Methods-and-Callbacks"
    "Auth-Friends"
    "Car-Sales"
    "DOM-I"
    "DOM-II"
    "JavaScript-Foundations"
    "JS-Exercise-Classes"
    "JS-Exercise-Functions-Arrays-Objects"
    "JS-Exercise-Prototype"
    "Computer-Architecture"
    "CS35_DataStructures_GP"
    "CS35_IntroPython_GP"
    "Data-Structures"
    "Graphs"
    "Intro-Python-I"
    "Intro-Python-II"
    "Sprint-Challenge--Algorithms"
    "Sprint-Challenge--Data-Structures-Python"
    "Sprint-Challenge--Intro-Python"
    "Sprint-Challenge--JavaScript"
    "Sprint-Challenge--User-Interface"
    "Sprint-Challenge-Applied-Javascript"
    "Sprint-Challenge-React-Wars"
    "Preprocessing-I"
    "Preprocessing-II"
)

declare -a CATEGORY_2=(
    "node-api1-guided"
    "node-api2-guided"
    "node-api3-guided"
    "node-api4-guided"
    "node-api1-project"
    "node-api2-project"
    "node-api3-project"
    "node-api4-project"
    "node-auth1-guided"
    "node-auth1-project"
    "node-auth2-guided"
    "node-auth2-project"
    "node-db1-guided"
    "node-db1-project"
    "node-db2-guided"
    "node-db2-project"
    "node-db3-guided"
    "node-db3-project"
    "node-db4-guided"
    "node-db4-project"
    "node-server-testing-guided"
    "node-server-testing-challenge"
    "learn-cicd-starter"
    "megacorp"
    "HTTP-Movies-Assignment"
    "Responsive-Design"
    "Git-Flow-Practice"
    "Git-for-Web-Development-Project"
)

declare -a CATEGORY_3=(
    "clearbit-playground"
    "clearbit-name-to-domain-api"
    "dark-mode"
    "nasa-photo-of-the-day"
)

# Combine all arrays
declare -a ALL_REPOS=("${CATEGORY_1[@]}" "${CATEGORY_2[@]}" "${CATEGORY_3[@]}")

echo -e "${YELLOW}GitHub Repository Archiver${NC}"
echo "======================================"
echo "Owner: $OWNER"
echo "Total repos to archive: ${#ALL_REPOS[@]}"
echo ""
echo -e "${YELLOW}Category 1 (Learning/Training):${NC} ${#CATEGORY_1[@]} repos"
echo -e "${YELLOW}Category 2 (Tutorial/Course):${NC} ${#CATEGORY_2[@]} repos"
echo -e "${YELLOW}Category 3 (Demos & Experiments):${NC} ${#CATEGORY_3[@]} repos"
echo ""

# Check if GitHub CLI is installed
if ! command -v gh &> /dev/null; then
    echo -e "${RED}Error: GitHub CLI (gh) is not installed.${NC}"
    echo "Please install it from: https://cli.github.com/"
    exit 1
fi

# Check authentication
if ! gh auth status &> /dev/null; then
    echo -e "${RED}Error: Not authenticated with GitHub CLI.${NC}"
    echo "Please run: gh auth login"
    exit 1
fi

echo -e "${YELLOW}Starting archival process...${NC}"
echo ""

# Counter for success/failure
success=0
failed=0
failed_repos=()

# Archive each repository
for repo in "${ALL_REPOS[@]}"; do
    echo -n "Archiving $repo... "
    
    if gh repo archive "$OWNER/$repo" --confirm 2>/dev/null; then
        echo -e "${GREEN}✓ Success${NC}"
        ((success++))
    else
        echo -e "${RED}✗ Failed${NC}"
        ((failed++))
        failed_repos+=("$repo")
    fi
done

echo ""
echo "======================================"
echo -e "Summary:"
echo -e "${GREEN}Successfully archived: $success${NC}"
echo -e "${RED}Failed: $failed${NC}"

if [ $failed -gt 0 ]; then
    echo ""
    echo -e "${RED}Failed repositories:${NC}"
    for repo in "${failed_repos[@]}"; do
        echo "  - $repo"
    done
fi

echo ""
echo "Archival process complete!"
