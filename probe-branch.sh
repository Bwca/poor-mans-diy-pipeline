#!/bin/bash

declare -r app_folder=$1
declare -r branch=$2
declare current_branch
declare -a commands=("lint" "test" "build")

declare has_stash


function stash_current_changes(){
    git add .
    if echo $(git stash push) | grep --quiet "Saved working directory";
    then
        echo true
    else
        echo false
    fi
}

function restore_stash(){
    declare has_stash_to_restore=$1
    
    if [ "$has_stash_to_restore" = true ]; then
        git stash apply
    fi
}

echo -e "Selected folder: $app_folder \n branch to check: $branch\n"

cd $app_folder

current_branch=$(git branch --show-current)

echo -e "Current branch is $current_branch \n stashing current changes \n stashing result $stashing_result\n"

has_stash=$(stash_current_changes)

echo -e "Has stash: $has_stash\n"
echo "Checking out branch..."

git checkout $branch
echo -e "Checked out $branch\n"

npm i

for i in ${commands[@]}
do
    echo "Doing $i"
    npm run $i || break;
done

echo -e "Switching back to previous branch which is $current_branch\n"
git checkout $current_branch
echo "Checked out $current_branch"
$(restore_stash $has_stash)

exit 0