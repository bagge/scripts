#!/bin/bash

source_line="deb http://repository.spotify.com stable non-free"
sources_list=/etc/apt/sources.list

echo "Checking sources.list ..."
grep -q "$source_line" $sources_list
if [ $? -eq 1 ]; then
    echo "Adding source to sources.list..."
    echo $source_line >> $sources_list
else
    echo "Source found"
fi

echo "Getting key ..."
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4E9CFF4E
if [ $? -eq 1 ]; then
    echo "Failed"
    exit 1
fi

echo "Updating sources ..."
apt-get update
if [ $? -eq 1 ]; then
    echo "Failed"
    exit 1
fi

echo "Installing spotify ..."
apt-get install spotify-client-qt
if [ $? -eq 1 ]; then
    echo "Failed"
    exit 1
fi


