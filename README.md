# Poor man's DIY pipeline for frontend

When you have no CI/CD pipeline configured but you want to run checks on a branch.

Just don't ask why...

## What does it do

Checks out branch and performs checks on it.

Comes handy when there's no CI/CD pipes configured...

First argument is the path to the directory, second is the name of the branch to check.

```bash
# path to the folder here, pass via command line 
# or just change the code
declare -r app_folder=$1

# branch name, same as the above
declare -r branch=$2
declare current_branch

# list of commands to run via npm
declare -a commands=("lint" "test" "build")
```

It stashes all current changes, switches to the designated branch, performs checks, then switches back to the previous branch and applies saved stash if there was any.

That's all there is to it.
