`wal-discord` replaces the one in ~/.local/bin/wal-discord, and `master.scss` replaces the one in the wal-discord config. Together they fix the transparent popup issue I was having with discord.

`aur-updates.sh` requires a cronjob to run it at set intervals (I usually do every minute).
Add it to a crontab or make a symbolic link to the script in /etc/cron.minutely
