#!/bin/bash

for dir in `ls -d */`
do
     
     cd $dir 
     python sonar.py
     cd ..

done

   