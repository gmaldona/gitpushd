#!/bin/bash
######### GM ########################################################### 80 ####
#                                                                              #
# author: GM                                                                   #
# email:  gmaldonado@cs.binghamton.edu                                         #
# date:   2023-12-05                                                           #
#                                                                              #
# gitpopd.sh -                                                                 #
#                                                                              #
# Similar to GNU popd where a user that pushd directory, can pop the directory #
# stack to be placed in original directory.                                    #
# Gitpushd is designed for frequent branch switching on a git project.         #
#                                                                              #
# Usage:                                                                       #
# A branch that has been previous "pushed" on the stack, can pop the branch    #
# to be placed in the original working branch. The stacks are project specific #
# so pushed branches are mixed with each other.                                #
#                                                                              #
######### GM ########################################################### 80 ####

project=$(git worktree list | cut -d ' ' -f 1)
[ -n "$project" ] && project=$(echo $project | xargs basename) || exit 1

target="$HOME/.gitpushd/$project" && [ ! -d "$target" ] && exit 1
branch=$(git rev-parse --abbrev-ref HEAD)
prevbr="$branch"

pushd $target >/dev/null

# pop top of the branch stack
branch=$(tail "$target") && git checkout $branch

if [ $(git rev-parse --abbrev-ref HEAD) != "$prevbr" ]; then
   echo $branch
   sed -i '' -e '$ d' .gitpushd 
fi

popd >/dev/null

######### GM ########################################################### 80 ####