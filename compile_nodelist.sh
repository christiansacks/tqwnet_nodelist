#!/bin/bash

ORIGDIR=$PWD
IWORKDIR="/root/git/tqwnet_nodelist"
IPACKDIR="/root/git/tqwnet_infopack"
WORKDIR="${1:-IWORKDIR}"
PACKDIR="${2:-IPACKDIR}"

COMMIT="$(date "+%Y-%m-%d %H:%M:%S")"

cd $WORKDIR
git pull

makenl -d nodelist.txt

absfile=$(ls -rt outfile/* | tail -1)
file=$(echo $(basename $absfile))
ext=$(echo $file | awk -F. '{ print $2 }') 
newext="z${ext:1:2}" 

zip -j9 zip/tqwnet.$newext $absfile

git add . -A
git commit -m "$COMMIT"
git push

cd $PACKDIR

rm tqwnet.z*
rm tqwinfo.zip
cp $WORKDIR/zip/tqwnet.$newext .
zip -9 tqwinfo.zip *

git add . -A
git commit -m "$COMMIT"
git push

cd $ORIGDIR

