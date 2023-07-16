#!/bin/bash

while true; do
    current_time=$(date "+%Y-%m-%d %H:%M:%S")
    echo "[cron] kehadiran-parser @ $current_time"
    git reset --hard origin/main
    ./kehadiran-parser
    git add -A
    git commit -m 'kehadiran-parser auto update'
    git push
    sleep 60
done
