#! /bin/bash

echo -e "Enter the first file name \n"
read file1 

echo -e "Enter the second file name \n"
read file2

if [[ $file1 = $file2 ]]
then
echo -e "Both are equal \n"
else
echo -e "Both files are different \n"
