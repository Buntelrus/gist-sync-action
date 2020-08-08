#!/bin/bash

# $1 :: ${{ inputs.auth_token }}
# $2 :: ${{ inputs.auth_user }}
# $3 :: ${{ inputs.auth_email }}
# $4 :: ${{ inputs.gist_url }}
# $5 :: ${{ inputs.file }}
# $6 :: ${{ inputs.history }}

auth_token=$1
auth_user=$2
auth_email=$4
gist_url=$4
file=$5
history=$6

git config --global user.email ${auth_email}
git config --global user.name ${auth_user}

gist_url_array=($(sed 's|//|\n|g' <<< "$gist_url"))

git clone ${gist_url_array[0]}//${auth_user}:${auth_token}@${gist_url_array[1]} gist
file_name_parts=($(echo $file | tr "/" "\n"))
gist_file=${file_name_parts[-1]}
if [[ ! -f gist/${gist_file} ]]; then
    touch gist/${gist_file}
fi
cat ${file} > gist/${gist_file}
cd gist
git add ${gist_file}
if [[ "$history" = true ]]; then
    git commit -m 'update gist via gist-sync-action'
    git push
else
    git commit --amend -m 'update gist via gist-sync-action'
    git push -f
fi