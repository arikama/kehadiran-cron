#!/bin/bash

run_cmd() {
    if [[ $PROD -eq 1 ]]; then
        eval $1
    else
        echo $1
    fi
}

log_info() {
    current_time=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    echo "[cron] $current_time >> $1"
}

while true; do
    log_info "running parser"
    run_cmd "$PARSER_BIN --pdf-dir=$PARSER_PDF_DIR --out-dir=$PARSER_OUT"
    log_info "parser done"

    log_info "pushing update"
    run_cmd "git reset --hard origin/main"
    run_cmd "git add -A"
    run_cmd "git commit -m 'kehadiran auto update'"
    run_cmd "git push"
    log_info "update done"

    log_info "sleeping for $SLEEP_SEC seconds"
    sleep $SLEEP_SEC
done
