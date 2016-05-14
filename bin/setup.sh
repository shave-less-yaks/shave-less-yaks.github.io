#!/bin/sh

# Clean what's there already
rm -Rf _deploy/*
rm -Rf _deploy/.* 1>/dev/null 2>&1

# Copy git references
cp -R .git _deploy/
touch _deploy/.keep

# Change branch
cd _deploy
git checkout master

echo 'Ready'
