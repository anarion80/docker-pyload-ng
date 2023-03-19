#!/bin/bash

# Script to trigger build action when there is a change in pyload repository

# Set the repository URL and the target URL
repository_url="https://github.com/pyload/pyload"
target_url="https://api.github.com/repos/anarion80/docker-pyload-ng/actions/workflows/build-and-publish.yml/dispatches"
Pushover_URL='https://api.pushover.net/1/messages.json'
Pushover_Token='<token>'
Pushover_User_Key='<user_key>'
Github_Token='<github_token>'
if [ -z "$1" ]; then
    branch="main"
else
    branch="$1"
fi

# Extract the repository owner and name from the repository URL
repository_owner=$(echo "$repository_url" | cut -d '/' -f 4)
repository_name=$(echo "$repository_url" | cut -d '/' -f 5 | cut -d '.' -f 1)

# Get the current commit hash for the repository using the GitHub API
current_commit=$(curl -s "https://api.github.com/repos/$repository_owner/$repository_name/git/refs/heads/$branch" | jq -r .object.sha)

# Check if the commit hash has changed
if [ -f .last_commit ] && [ "$current_commit" == "$(cat .last_commit)" ]; then
    # Commit hash has not changed, exit the script
    exit 0
fi

# Pushover notification
/usr/bin/curl -X POST -s \
    --form-string "token=${Pushover_Token}" \
    --form-string "user=${Pushover_User_Key}" \
    --form-string "message=${branch} updated to ${current_commit}" \
    --form-string "title=pyLoad ${branch} updated" \
    "${Pushover_URL}" > /dev/null 2>&1

# Update the .last_commit file with the new commit hash
echo "$current_commit" > .last_commit
