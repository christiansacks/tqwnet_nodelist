#!/bin/bash

ORIGDIR=$PWD
WORKDIR="/~/git/tqwnet_nodelist"

cd $WORKDIR

makenl -d nodelist.txt

absfile=$(ls -rt outfile/* | tail -1)
file=$(echo $(basename $absfile))
ext=$(echo $file | awk -F. '{ print $2 }') 
newext="z${ext:1:2}" 

zip -j9 zip/tqwnet.$newext $absfile

cd $ORIGDIR
