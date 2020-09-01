#!/bin/bash

absfile=$(ls -rt outfile/* | tail -1)
file=$(echo $(basename $absfile))
ext=$(echo $file | awk -F. '{ print $2 }') 
newext="z${ext:1:2}" 
newfile="tqwnet.$newext"
zip -j9 zip/$newfile $absfile

