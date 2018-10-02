#!/bin/bash
array_item_getter(){
	i=0
	for dirItem in $1
	do
		dirItemFile[i]=$dirItem
		i++
	done
	i=0
	for dirPermisisons $2
	do
		dirItemPermisison[i]=$dirPermissions
		i++
	done
	j=0
	until [$j -eq $i]
	do
		echo "File: $dirItemFile[j] \nPermissions: $permissions[j] \n"


	done 		
}

directoryInput=$1
directoryInput=${directoryInput:=$PWD}
directoryList=$(ls -l "$directoryInput"| tr -s " " | cut -f9 -d ' ' )
directoryPermissiosn=$( ls -l "$directoryinput" | tr -s " "| cut -f1 -d' ' )
test=$(ls)
#array_item_getter $directoryList
echo $directoryList
