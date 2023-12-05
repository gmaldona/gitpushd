#!/bin/bash

# author: Gregory Maldonado
# date:   2023-12-05

# gitpopd.sh -

# Similar to GNU popd where a user that pushd a directory, can pop the directory
# stack to be placed in original directory.
# Gitpushd is designed for frequent branch switching on a git project.

# Usage:
# A branch that has been previous "pushed" on the stack, can pop the branch
# to be placed in the original working branch. The stacks are project specific
# so pushed branches are mixed with each other.

gitroot=$(git worktree list | cut -d ' ' -f 1)

if [ -n $gitroot ]; then 
   exit 1
fi 

project=$(echo $gitroot | xargs basename)

target="$HOME/.gitpushd/$project"
branch=$(git rev-parse --abbrev-ref HEAD)

if [ ! -d $target ]; then
   exit 1
fi

pushd $target >/dev/null

branch=$(tail ~/.gitpushd/cis-554/.gitpushd)
sed -i '' -e '$ d' .gitpushd # pop top of the branch stack

popd >/dev/null

git checkout $branch && echo $branch

