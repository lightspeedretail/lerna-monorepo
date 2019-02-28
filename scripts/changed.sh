#!/bin/sh
echo "Going to check the version"
VERSION=$(yarn lerna:changed)
echo $VERSION
FOUND_APP=$(echo $VERSION | grep $1)
if [ "$1" = "$FOUND_APP" ]; then
    echo "App is changed, continuing "
    exit 0
else
    echo "App is not changed, we'll stop here"
    exit 78
fi