#!/bin/bash

function log() {
    if [[ "$@" ]]; then echo "[Neos] $@";
    else echo; fi
}

function wait_for_db() {
    set +e
    local res=1
    while [[ $res -ne 0 ]]; do
        mysql $MYSQL_CMD_PARAMS --execute "status" 1>/dev/null
        res=$?
        if [[ $res -ne 0 ]]; then log "Waiting for DB service ($NEOS_DB_HOST:$NEOS_DB_PORT username:$NEOS_DB_USER)..." && sleep 2; fi
    done
    set -e

    # Display DB status...
    log "Database status:"
    mysql $MYSQL_CMD_PARAMS --execute "status"
}

function create_app_db() {
    log "Creating Neos database '$NEOS_DB_NAME' (if it doesn't exist yet)..."
    mysql $MYSQL_CMD_PARAMS --execute="CREATE DATABASE IF NOT EXISTS $NEOS_DB_NAME CHARACTER SET utf8 COLLATE utf8_unicode_ci"
    log "DB created."
}

function get_db_executed_migrations() {
    local v=$(/var/www/neos/flow doctrine:migrationstatus | grep -i 'Executed Migrations' | awk '{print $4$5}')
    echo $v
}