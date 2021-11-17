#!/bin/bash

CURTAG=`git describe --abbrev=0 --tags`;
CURTAG="${CURTAG/v/}"

IFS='.' read -a vers <<< "$CURTAG"

MAJ=${vers[0]}
MIN=${vers[1]}
REV=${vers[2]}
echo "Current Tag: v$MAJ.$MIN.$REV"
CNT=$( git rev-list  `git rev-list --tags --no-walk --max-count=1`..HEAD --count )

if [ "$CNT" = "0" ]; then
	echo "No commits since last tag, no new tag will be created"
	exit 0
fi

for cmd in "$@"
do
	case $cmd in
		"--major")
			# $((MAJ+1))
			((MAJ+=1))
			MIN=0
			BUG=0
			echo "Incrementing Major Version#"
			;;
		"--minor")
			((MIN+=1))
			BUG=0
			echo "Incrementing Minor Version#"
			;;
		"--rev")
			((REV+=1))
			echo "Incrementing Bug Version#"
			;;
	esac
done
NEWTAG="v$MAJ.$MIN.$REV"
echo "Adding Tag: $NEWTAG";
git tag -a $NEWTAG -m $NEWTAG
