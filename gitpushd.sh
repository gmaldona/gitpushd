#!/bin/bash

# author: Gregory Maldonado
# date:   2023-12-05

# gitpushd.sh -

# Similar to GNU pushd where a user can pushd a directory
# to be later "popped". Stack based directory tracking.
# Gitpushd is designed for frequent branch switching on a git project.

# Usage:
# The current working branch can be "pushed" onto a stack. User may switch to a
# new branch and later "pop" the stack to be placed back into the original
# branch. The stacks are project specific so pushed branches are mixed with each
# other.

if [ ! -d $HOME/.gitpushd ]; then
   mkdir $HOME/.gitpushd
fi

gitroot=$(git worktree list | cut -d ' ' -f 1)
if [ -n $gitroot ]; then 
   exit 1
fi 

project=$(echo $gitroot | xargs basename)

target="$HOME/.gitpushd/$project"
branch=$(git rev-parse --abbrev-ref HEAD)

if [ ! -d $target ]; then
   mkdir -p $target
   touch $target/.gitpushd
fi

pushd "$target" /dev/null >/dev/null

# push to the top of the branch stack
grep -q $branch .gitpushd && : || echo $branch >>.gitpushd
echo $branch

popd >/dev/null
