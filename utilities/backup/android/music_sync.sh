#!/bin/bash

usage() {
    cat <<EOF # remove the space between << and EOF, this is due to web plugin issue
Usage: $(
        basename "${BASH_SOURCE[0]}"
    ) [-h] [-a] value [-d] value [-u] value [-H] value

Script description here.

Available options:

-h, --help                      Print this help and exit
-a, --android-music-dir         Directory where music is stored on Android device
-d, --destination-music-dir     Directory where music is stored on Host device
-u, --user                      Username of the host device
-H, --host-address              Host address of the host device
-m, --mode                      Sync mode. Available options are "pull" (to pull files from\
host onto android device) and "push" (to push files from android device to host) 
EOF
    exit
}

msg() {
    echo >&2 -e "${1-}"
}

die() {
    local msg=$1
    local code=${2-1} # default exit status 1
    msg "$msg"
    exit "$code"
}

parse_params() {
    # default values of variables set from params
    android_music_dir=~/storage/music/*
    destination_music_dir='~/Music'
    user=
    host_address=
    mode=

    while :; do
        case "${1-}" in
        -h | --help) usage ;;
        -a | --android-music-dir)
            android_music_dir=${2}
            shift
            ;;
        -d | --destination-music-dir)
            destination_music_dir=${2}
            shift
            ;;
        -u | --user)
            user=${2}
            shift
            ;;
        -H | --host-address)
            host_address=${2}
            shift
            ;;
        -m | --mode)
            mode=${2}
            shift
            ;;
        -?*) die "Unknown option: $1" ;;
        *) break ;;
        esac
        shift
    done

    [[ -z "${user}" ]] && die "Missing required parameter: --user"
    [[ -z "${mode}" ]] && die "Missing required parameter: --mode"
    [[ -z "${host_address}" ]] && die "Missing required parameter: --host-address"

    return 0
}

parse_params "$@"

case $mode in
    pull)
        rsync -zauP $user@$host_address:$destination_music_dir $android_music_dir;;
    push)
        rsync -zauP $android_music_dir $user@$host_address:$destination_music_dir ;;
    *)
        die "Invalid mode $mode" ;;
esac
