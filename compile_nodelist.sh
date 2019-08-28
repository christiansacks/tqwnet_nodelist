#!/bin/bash

absfile=$(ls -rt outfile/* | tail -1)
echo $absfile

file=$(echo $(basename $absfile))
echo $file

ext=$(echo $file | awk -F. '{ print $2 }') 
echo $ext

newext="z${ext:1:2}" 
echo $newext

zip -j9 zip/tqwnet.$newext $absfile

