#!/bin/bash

usage() {
    cat <<EOF # remove the space between << and EOF, this is due to web plugin issue
Usage: $(
        basename "${BASH_SOURCE[0]}"
    ) [-h] [-d] value [-u] value
Script description here.
Available options:
-h, --help                      Print this help and exit
-d, --dns-ip                    Ip address of the DNS
-u, --interface-uuid            The uuid of interface. Can be found by "running nmcli c s"

EOF
    exit
}

msg() {
    echo >&2 -e "${1-}"
}

die() {
    local msg=$1
    local code=1
    msg "$msg"
    exit "$code"
}

parse_params() {
    # default values of variables set from params
    interface_uuid=
    dns_ip=

    while :; do
        case "${1-}" in
        -h | --help) usage ;;
        -d | --dns-ip)
            dns_ip=${2}
            shift
            ;;
        -u | --interface-uuid)
            interface_uuid=${2}
            shift
            ;;
        -?*) die "Unknown option: $1" ;;
        *) break ;;
        esac

        shift
    done

    [[ -z "${dns_ip}" ]] && die "Missing required parameter: --dns-ip"
    [[ -z "${interface_uuid}" ]] && die "Missing required parameter: --interface-uuid"

    return 0
}

parse_params "$@"

sudo nmcli c m $interface_uuid ipv4.dns $dns_ip
sudo nmcli c m $interface_uuid ipv4.dns-search $dns_ip
sudo nmcli c up $interface_uuid
