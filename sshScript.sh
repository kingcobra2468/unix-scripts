#!/bin/bash
#################################
#Your ssh connection            #
ssh_connection="user@00.0.0.00" #
#################################
server="d"
function fileSeperator(){
    #shift
    text=""
    data=$1
    #echo $x 
    i=0
    extra=$2
    for single in $data;
        do
            i=$[i+1]
            x=$[$#-$i]
                if [[ "$x" == 0 ]];
                    then    
                        text="$text$extra$single"
                else        
                    text="$text$extra$single "
                fi
    done
    echo "$text"
}

while getopts "u:d:p:" option; 
    do
        case $option in
            u)
                i=0
                output=$(fileSeperator "$OPTARG" "")
                server="scp $output $ssh_connection:"

                ;;
            d)
                i=1
                output=$(fileSeperator "$OPTARG" "$ssh_connection:")
                server="scp $output"

                ;;         
            p)
                _path=$OPTARG

                ;;
        esac
    done
_path=${_path:=~/}
if [[ $i == 0 ]];
    then
        compile="$server$_path"
else
    compile="$server $_path"    
fi
eval $compile
