#!/bin/sh

echo "Going to check the changed apps"

CHANGED_APPS=$(lerna changed)
echo "Changed apps: $CHANGED_APPS"
FOUND_APP=$(echo $CHANGED_APPS | grep $1)
if [ "$1" = "$FOUND_APP" ]; then
    echo "App is changed, continuing "
    exit 0
else
    echo "App is not changed, we'll stop here"
    exit 78
fi
