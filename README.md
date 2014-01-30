BitDefender Scan
================

Bash script to scan for viruses on unix/linux server using BitDefender, a mail is sent if a virus is found.

Configuration
-------------

Open **bitdefender-scan.sh** file and adjust configuration variables

Variable     | Example value        | Description
-------------|----------------------|------------
mail_to      | you@test.com         | The mail adresse the scan log is sent to
mail_subject | BitDefender scan     | The mail subject
mail_header  | scan on monday       | The mail body header
log_file     |./bitdefender-log.log | the name of the log file
report_file  |./bitdefender.report  | the name of the report file


Usage
-----

Make **bitdefender-scan.sh** file executable, and run it:

```
chmod u+x bitdefender-scan.sh
./bitdefender-scan.sh <folder_or_file>
