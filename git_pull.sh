#!/bin/bash

# find the any directories in /opt/ that have a .git file and list them
repos=`find /opt/ -name '*.git' -printf '%h\n' | sort -u`

echo "Found following repositories
$repos"

for item in $repos; do
	cd $item && echo "===updating $item===" && git pull;
done