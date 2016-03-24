#!/bin/sh

function usage {
  echo 'Script to publish your changes to the live site'
  echo 'Usage: publish.sh "MESSAGE" PUSH-COMMIT'
  echo 'MESSAGE will be used as the commit message'
  echo 'PUSH-COMMIT is optional, and if Y then the commit will be pushed to the remote origin'
}

MESSAGE=$1
PUSH=$2

if [[ -z $MESSAGE ]]; then
  usage
  exit 1
fi

rsync -a _site/* _deploy/
cp CNAME _deploy/
cd _deploy
git add .
git commit -m "$MESSAGE"

if [[ $PUSH == 'Y' || $PUSH == 'y' ]]; then
  git push
fi
