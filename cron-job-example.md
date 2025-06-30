# Cron Job Example for Automated Backup System

## Overview
This file provides an example of how to set up a cron job to run the backup script automatically at scheduled intervals.

## Cron Job Syntax
```
* * * * * /path/to/automated_backup.sh
- - - - -
| | | | |
| | | | |____ Day of the week (0 - 7) [Sunday = 0 or 7]
| | | |______ Month (1 - 12)
| | |________ Day of the month (1 - 31)
| |__________ Hour (0 - 23)
|____________ Minute (0 - 59)
```

## Example Cron Job Entries

### 1. Run the Backup Script Every Friday at 17:00
```
0 17 * * 5 /path/to/automated_backup.sh >> /var/log/backup_cron_output.log 2>&1
```

## Setting Up the Cron Job
1. Open the crontab editor:
   ```bash
   crontab -e
   ```
2. Add the desired cron job entry (e.g., every Friday at 17:00).
3. Save and exit the editor.
4. Verify the cron job is scheduled:
   ```bash
   crontab -l
   ```

## Notes
- Ensure `automated_backup.sh` has execute permissions:
  ```bash
  chmod +x /path/to/automated_backup.sh
  ```
- Logs are stored in `/var/log/backup_cron_output.log` for monitoring.
- Adjust the schedule based on your backup frequency needs.

## Understanding `2>&1`
In the cron job command:
```
0 17 * * 5 /path/to/automated_backup.sh >> /var/log/backup_cron_output.log 2>&1
```
- `>> /var/log/backup_cron_output.log` appends standard output (stdout) to the log file.
- `2>&1` redirects standard error (stderr) to stdout, ensuring both output and errors are logged in the same file.