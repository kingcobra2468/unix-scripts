#!/bin/bash


function usage() {
    cat <<EOUSAGE >&2
Usage: $NAME [OPTIONS] ARGS...
Rotate backups such that only the n newest backups are kept with the rest
being deleted.
OPTION      DESCRIPTION
==========  ==================================================================
-n <num>     Number of backups to keep
-d <dir>     Directory where backups are kept
-h           This text
EOUSAGE
}

# Prune the n oldest backups
function prune_backups() {
    # fetch number of backups to delete
    num_old=$(($(ls $1 | wc -l) - $2))
    if [[ $num_old -le 0 ]]; then 
        return 0
    fi
    
    # delete num_old oldest backups 
    old_backups=$(ls -t $1 | tail -n$num_old)
    pushd $1
    rm $old_backups
    popd
}

while getopts "n:d:h" option; do
    case $option in
        n)
            num_backups=$OPTARG
            ;;
        d)
            backup_directory=$OPTARG
            ;;
        h)
            usage
            exit 0
            ;;
   esac
done

if [[ -z $num_backups ]] || [[ -z $backup_directory ]]; then
    echo "both -n and -d flags must be set"
    exit 1
fi

prune_backups $backup_directory $num_backups