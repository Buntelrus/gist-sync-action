#!/bin/bash

# $1 :: ${{ inputs.auth_token }}
# $2 :: ${{ inputs.auth_user }}
# $3 :: ${{ inputs.auth_email }}
# $4 :: ${{ inputs.gist_url }}
# $5 :: ${{ inputs.dir }}
# $6 :: ${{ inputs.files }}
# $7 :: ${{ inputs.history }}

auth_token=$1
auth_user=$2
auth_email=$4
gist_url=$4
dir=$5
files=$6
history=$7

DIR=$(pwd)

git config --global user.email ${auth_email}
git config --global user.name ${auth_user}

gist_url_array=($(sed 's|//|\n|g' <<< "$gist_url"))

git clone ${gist_url_array[0]}//${auth_user}:${auth_token}@${gist_url_array[1]} gist
for file in ${files}; do
    cd $DIR
    echo ${dir}/${file}
    gist_file=gist/${file}
    if [[ ! -f ${gist_file} ]]; then
        touch ${gist_file}
    fi
    cat ${dir}/${file} > ${gist_file}
    cd gist
    git add ${file}
done
if [[ "$history" = true ]]; then
    git commit -m 'update gist via gist-sync-action'
    git push
else
    git commit --amend -m 'update gist via gist-sync-action'
    git push -f
fi