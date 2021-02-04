#!/bin/sh -l

TOKEN=$1
REPOSITORY=$2
OWNER=$3
BRANCH=$4
FORCE=$5
DIRECTORY=$6
IGNORE=$7

_GIT_OPTION=''

echo "Push to branch $BRANCH";
if ${INPUT_FORCE}; then
    _GIT_OPTION='${_GIT_OPTION} --force'
fi

# SETUP SOURCE REPOSITORY
## get current directory
SOURCE_REPOSITORY=$PWD
cd ..

# SETUP TARGET REPOSITORY
## clone target repository
git clone "https://${OWNER}:${TOKEN}@github.com/${REPOSITORY}.git"
cd ${REPOSITORY}

## get latest changes and change branches
git fetch origin
git checkout ${BRANCH}

## create target folder if not exist
mkdir -p ${DIRECTORY}

# COPY FILES
## create rsync exclude option
_EXCLUDE_OPTION="--exclude .git"
for i in ${IGNORE//,/ }
do
    _EXCLUDE_OPTION="${_EXCLUDE_OPTION} --exclude $i"
done

## copy files
rsync -a ${_EXCLUDE_OPTION} ${SOURCE_REPOSITORY} "./${DIRECTORY}"

# create commit
git add -A
git commit -m "Latest changes from ${OWNER}/${REPOSITORY}"
git push origin ${BRANCH}