#!/bin/bash

read -p "gitlab ssh: " GITLAB
read -p "github ssh: " GITHUB
GITDIR=$(awk -F/ '{print $NF}' <<< $GITLAB | awk -F[.] '{print $1}')

echo "#### Cloning from gitlab ####"
git clone $GITLAB

echo "#### Changing working directory to $GITDIR ####"
cd $GITDIR

echo "#### Fetching all tags and branches from remote ####"
git branch -r | grep -v '\->' | while read remote; do git branch --track "${remote#origin/}" "$remote"; done
git pull --all

echo "#### Adding the remote github repo that will receive the codebase ####"
git remote add github $GITHUB

echo "#### Pushing the codebase along with the tags ####"
git push --all github
git push --tags github

echo "#### Updating upstream pointer ####"
git branch --set-upstream-to=github/master master
git remote rm origin

echo "#### That's all folks! ####"
