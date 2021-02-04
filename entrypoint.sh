#!/bin/sh -l

TOKEN=$1
REPOSITORY=$2
BRANCH=$3
FORCE=$4
DIRECTORY=$5
IGNORE=$6

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
git clone "https://${TOKEN}@github.com/${GITHUB_REPOSITORY_OWNER}/${REPOSITORY}.git"
cd ${REPOSITORY}

echo "get latest changes and change branches"
git fetch origin
git checkout -b ${BRANCH}

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
git config --global user.email "${GITHUB_REPOSITORY}@push-latest-changes-action"
git config --global user.name "${GITHUB_REPOSITORY}"
git add -A
git commit -m "Latest changes from ${GITHUB_REPOSITORY}"
git push origin "${BRANCH} ${_GIT_OPTION}"