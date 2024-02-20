#!/bin/bash
######### GM ########################################################### 80 ####
#                                                                              #
# author: GM                                                                   #
# email:  gmaldonado@cs.binghamton.edu                                         #
# date:   2023-12-05                                                           #
#                                                                              #
# gitpushd.sh -                                                                #
#                                                                              #
# Similar to GNU pushd where a user can pushd a directory                      #
# to be later "popped". Stack based directory tracking.                        #
# Gitpushd is designed for frequent branch switching on a git project.         #
#                                                                              #
# Usage:                                                                       #
# The current working branch can be "pushed" onto a stack. Users switches to a #
# new branch and later "pop" the stack to be placed back into the original     #
# branch.                                                                      #
#                                                                              #
# Arguments:                                                                   #
#                                                                              # 
# --clear | --clean           clears content out of .gitpushd and .history for #
#                             the given project context                        #
#                                                                              #
# --history                   displays history of "pushed" branches for the    #
#                             given project context                            #
#                                                                              #
######### GM ########################################################### 80 ####

project=$(git worktree list | cut -d ' ' -f 1)
[ -n "$project" ] && project=$(echo $project | xargs basename) || exit 1

target="$HOME/.gitpushd/$project"
branch=$(git rev-parse --abbrev-ref HEAD)

if [ ! -d "$target" ]; then
   mkdir -p "$target"
   touch    "$target/.gitpushd"
   touch    "$target/.history"
fi

if [ "$1" == "--history" ]; then
   cat "$target/.history"
elif [ "$1" == "--clear" ] || [ "$1" == "--clean" ]; then
   cat /dev/null > "$target/.gitpushd" && cat /dev/null > "$target/.history"
else
   pushd "$target" >/dev/null

   # push to the top of the branch stack
   grep -q $branch .gitpushd && : || echo $branch >>.gitpushd
   grep -q $branch .history  && : || echo $branch >>.history
   
   echo $branch && popd >/dev/null
fi

######### GM ########################################################### 80 ####