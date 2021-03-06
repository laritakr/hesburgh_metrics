#!/bin/bash

# Try to get a lock, and exit if someone else already has it.
# This keeps a lot of harvest processes from spawning
# should a paricular harvest take a long time.
# The lock is released when this shell exits.

 cd /home/app/metrics/current

 exec 200> "/tmp/weekly_metrics_report.sh"
 flock -e --nonblock 200 || exit 0

 source ./env-vars

# source our app environment.

 source /home/app/metrics/shared/system/metrics-env.sh

#Run this weekly metrics report in cron
export METRICS_START_DATE=$(date --date="7 days ago" +"%Y-%m-%d")
export METRICS_END_DATE=$(date +"%Y-%m-%d")
RAILS_ENV=$RAILS_ENV bundle exec rake metrics:generate_report 2>/home/app/metrics/shared/log/weekly_metrics_report.log
