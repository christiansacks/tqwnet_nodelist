#!/bin/bash
# v2

ORIGDIR=$PWD
IWORKDIR="/root/git/tqwnet_nodelist"
IPACKDIR="/root/git/tqwnet_infopack"
WORKDIR="${1:-$IWORKDIR}"
PACKDIR="${2:-$IPACKDIR}"

COMMIT="$(date "+%Y-%m-%d %H:%M:%S")"

ISOK=false

#echo -n "Did you save and commit changes in both $IWORKDIR and $IPACKDIR?: "; read ANSWER
#case "$ANSWER" in
#  "no")  echo "Aborted, go save and commit!"; exit 1;;
#  *) echo "continue";;
#esac

echo "*** DID YOU SAVE AND COMMIT YOUR CHANGES TO BOTH $WORKDIR AND $PACKDIR? ***"
for i in {5..1}; do
  echo -n "$i... "
  sleep 1
done
echo "0. Times up!"

cd $WORKDIR
git pull

echo "Compiling nodelist..."
makenl -d nodelist.txt >/dev/null

absfile=$(ls -rt outfile/* | tail -1)
file=$(echo $(basename $absfile))
ext=$(echo $file | awk -F. '{ print $2 }') 
newext="z${ext:1:2}" 

echo "Creating zip archive tqwnet.$newext..."
[ -f zip/tqwnet.$newext ] && mv zip/tqwnet.$newext{,.`date +%Y%m%d`}
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

