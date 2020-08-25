#!/bin/sh
# rewrites git commit history, replacing a commit email with a new one.
# usefull for git(lab) servers with policies to use company domain for commits only

git filter-branch --env-filter '
OLD_EMAIL="wrong_email@noreply.example.org"
CORRECT_NAME="Your Name"
CORRECT_EMAIL="name@company.com"

if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
export GIT_COMMITTER_NAME="$CORRECT_NAME"
export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
export GIT_AUTHOR_NAME="$CORRECT_NAME"
export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
