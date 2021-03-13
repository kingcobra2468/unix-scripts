#!/bin/bash

directory=""

if [[ $(date +%a) -eq "Sat" ]];
	then
		rm -fr $directory
fi