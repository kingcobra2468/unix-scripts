#!/bin/bash

# backup script of all needed dirs along with user remindomg

declare -rg SYSTEM_NAME="Desktop"
declare -rg REMINDER_PATH="$HOME/.backup_reminder"
declare -rg FULL_BACKUP_PATH="/tmp/$(date +%d.%B.%Y).SYSTEM_BACKUP.$SYSTEM_NAME.zip"
declare -rg SSH_HOST="erik@10.0.1.10"
declare -rg SSH_PATH_TO_SAVE="~/FullBackUps/"
declare -rg PATHS_TO_BACKUP=("$HOME/Documents/Programming" \
    "$HOME/Documents/PDFs" "$HOME/Documents/College" "$HOME/Desktop")

function check_beginning_of_month() {

    if [[ $(date +%-d) -eq 1 ]]; then
        echo -n 1
    else
        echo -n 0
    fi
}

function reminder_file_exists() {

    if [[ ! -w $HOME/.backup_reminder ]]; then
        echo $(check_beginning_of_month) > $REMINDER_PATH
    fi
}

function create_system_backup() {
    
    zip -dbr $FULL_BACKUP_PATH "${PATHS_TO_BACKUP[@]}"
    scp $FULL_BACKUP_PATH $SSH_HOST:$SSH_PATH_TO_SAVE
    rm $FULL_BACKUP_PATH
} 

function remind_user() {

    reminder_file_exists

    if [[ $(check_beginning_of_month) -eq 0 || $(cat $REMINDER_PATH) -eq 1 ]]; then

        echo -n "Do you want to backup your system ($SYSTEM_NAME) now (Yes/No): "
        read choice

        case $choice in 

            [Yy]es)
                create_system_backup
                exit 0
            ;;
            [Nn]o)
                echo 1 > $REMINDER_PATH
                exit 0
            ;;
            *)
                >&2 echo "Invalid choice $choice"
                exit 1
            ;;
        esac
    fi
}

# INIT STARTS BELOW
remind_user