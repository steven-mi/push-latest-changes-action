#!/bin/sh -l

TOKEN=$1
REPOSITORY=$2
OWNER=$3
BRANCH=$4
FORCE=$5
DIRECTORY=$6
IGNORE=$7

echo "setup git options";
_GIT_OPTION=''
if ${INPUT_FORCE}; then
    _GIT_OPTION='${_GIT_OPTION} --force'
fi

# SETUP SOURCE REPOSITORY
echo "get current directory"
SOURCE_REPOSITORY=$PWD

echo "switch to parent directory"
cd ..

# SETUP TARGET REPOSITORY
echo "clone target repository"
git clone "https://${TOKEN}@github.com/${OWNER}/${REPOSITORY}.git"
cd ${REPOSITORY}

echo "get latest changes and change branches"
git fetch origin
git checkout ${BRANCH}

echo "create target folder if not exist"
mkdir -p ${DIRECTORY}

# COPY FILES
echo "create rsync exclude option"
_EXCLUDE_OPTION="--exclude .git"
for i in ${IGNORE//,/ }
do
    _EXCLUDE_OPTION="${_EXCLUDE_OPTION} --exclude $i"
done

echo "copy files"
rsync -a ${_EXCLUDE_OPTION} ${SOURCE_REPOSITORY} "./${DIRECTORY}"

echo "create commit"
git add -A
git commit -m "Latest changes from ${OWNER}/${REPOSITORY}"
git push origin ${BRANCH}