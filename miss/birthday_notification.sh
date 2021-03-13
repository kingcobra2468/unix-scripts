#!/bin/bash
#5/20/18

birthdayData="/home/erik/names"
firstName=$( cat $birthdayData | tr -s " " | cut -f1 -d' ')
lastName=$(cut -f2 -d ' ' $birthdayData)
month=$(date +%m)
day=$(date +%d)
year=$(date +%Y)

if ! [[ -r $birthdayData ]];
	then
		a=${birthdayData##*/}
		temp=$(ls -l $birthdayData | grep $a | cut -f1 -d ' ')
		echo "$temp  READ PERMISSIONS MISSING"
		unset a; unset temp
		sleep 2
		exit
fi

function onePerAll(){
	i=0
	arr=$2
	#echo $arr
	elements=$1
	for name in $elements;
		do 
			#name=$(echo $name | tr -s " " )
			eval ${arr}[$i]=$name
			i=$[$i+1]
			#echo "i = $i"
	done
}
function bToB(){
	i=1 	
	until [ $i -gt ${#fArray[@]} ];
		do
			myDate=$(sed -n ${i}p $birthdayData)
			myDate=$(echo $myDate | sed 's#[/-]# #g')
			cday=$(echo $myDate | cut -f4 -d ' ')
			cmonth=$(echo $myDate | cut -f3 -d ' ')
			cyear=$(echo $myDate | cut -f5 -d ' ')
			if [[ $cmonth -eq $month ]] && [[ $cday -eq $day ]];
				then
						age=$((year-cyear))
						case $age in
							1)
								type="st";;
							2)
								type="nd";;
							3)
								type="rd";;
							*)
								type="th";;
						esac
						#echo -e "Today is ${fArray[$i-1]} ${lArray[$i-1]} $((year-cyear))th Birthday\n"
						notify-send -t 10 "     			           Today is ${fArray[$i-1]} ${lArray[$i-1]} $((year-cyear))$type Birthday"
			fi
			i=$[$i+1]
	done
	 
} 
#echo $firstName
onePerAll "$firstName" "fArray"
onePerAll "$lastName" "lArray"
bToB
