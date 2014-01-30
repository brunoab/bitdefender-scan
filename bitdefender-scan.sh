#!/bin/bash

#============================================#
# Config
#============================================#

report_file="bitdefender-report.log"
log_file="bitdefender-log.log"
mail_to=""
mail_subject="Bit-Defender scan"
mail_header=""

#============================================#
# Processing
#============================================#

target=$1
bitdefender_version=$(bdscan --version)
date_scan=$(date +"%a %b %d %H:%M:%S %Z %Y")

# refresh virus database
bdscan --update 1>/dev/null 2>/dev/null

# clean report file
echo "" > "$report_file"

# start scan
bdscan --log="$log_file" --quarantine="/opt/BitDefender-scanner/var/quarantine" --log-overwrite --no-archive --no-list --action=quarantine "$target" 1>"$report_file"

# check fot threats in report file
nb_infected=$(grep -o "Infected files: .*" "$report_file" | sed 's/Infected files: //')
nb_warnings=$(grep -o "Warnings: .*" "$report_file" | sed 's/Warnings: //')
nb_suspectd=$(grep -o "Suspect files: .*" "$report_file" | sed 's/Suspect files: //')

report="$mail_header"$(cat "$report_file")

# if any threat is found
if [ "$nb_infected" -gt "0" -o "$nb_warnings" -gt "0" -o "$nb_suspectd" -gt "0" ]; then
        # send report via mail
        printf "$report" | mail -s "$mail_subject" $mail_to
fi

# delete log and report files
rm -f "$report_file" 2> /dev/null
rm -f "$log_file" 2> /dev/null