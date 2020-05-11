#!/bin/bash

ORIGDIR=$PWD
IWORKDIR="/root/git/tqwnet_nodelist"
IPACKDIR="/root/git/tqwnet_infopack"
WORKDIR="${1:-IWORKDIR}"
PACKDIR="${2:-IPACKDIR}"

COMMIT="$(date "+%Y-%m-%d %H:%M:%S")"

cd $WORKDIR
git pull

echo "Compiling nodelist..."
makenl -d nodelist.txt >/dev/null

absfile=$(ls -rt outfile/* | tail -1)
file=$(echo $(basename $absfile))
ext=$(echo $file | awk -F. '{ print $2 }') 
newext="z${ext:1:2}" 

echo "Creating zip archive tqwnet.$newext..."
zip -j9 zip/tqwnet.$newext $absfile

git add . -A
git commit -m "$COMMIT"
git push

cd $PACKDIR
echo "Now in $PACKDIR directory..."

git pull

rm $PACKDIR/tqwnet.z*
rm $PACKDIR/tqwinfo.zip

echo "Copy $WORKDIR/zip/tqwnet.$newext $PACKDIR/"
cp $WORKDIR/zip/tqwnet.$newext $PACKDIR/

echo "Creating zip archive $PACKDIR/tqwinfo.zip..."
zip -j9 $PACKDIR/tqwinfo.zip $PACKDIR/*

git add . -A
git commit -m "$COMMIT"
git push

cd $ORIGDIR

