# gitpushd && gitpopd

## Problem
Constant switching feature branches at work; sometimes forgetting the branch name and having to go to
my MR stack on GitLab to figure out the branch I was just working on... bad memory... annoying.

## gitpushd

Similar to GNU pushd where a user can pushd a directory
to be later "popped". Stack based directory tracking.
Gitpushd is designed for frequent branch switching on a git project

### Usage:
The current working branch can be "pushed" onto a stack. User may switch to a
new branch and later "pop" the stack to be placed back into the original
branch. The stacks are project specific so pushed branches are mixed with each
other.

## gitpopd

Similar to GNU popd where a user that pushd a directory, can pop the directory
stack to be placed in original directory.
Gitpushd is designed for frequent branch switching on a git project

### Usage:
A branch that has been previous "pushed" on the stack, can pop the branch
to be placed in the original working branch. The stacks are project specific
so pushed branches are mixed with each other

## Copying to /usr/local/bin
To use as a regular bash function, the script must be symlinked inside of `/usr/local/bin`.

```bash
# never run a bash script you do not know what it is doing...
$ sudo ln -s $(realpath gitpushd.sh) /usr/local/bin/gitpushd && sudo ln -s $(realpath gitpopd.sh) /usr/local/bin/gitpopd
```
