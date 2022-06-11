`wal-discord` replaces the one in ~/.local/bin/wal-discord, and `master.scss` replaces the one in the wal-discord config. Together they fix the transparent popup issue I was having with discord.

`aur-updates.sh` requires a cronjob to run it at set intervals (I usually do every minute).
Add it to a crontab or make a symbolic link to the script in /etc/cron.minutely

Symlinks:
`wal/templates/dunstrc` to `~/.config/dunst/dunstrc`
Hardlinks:
`wal/templates/rofi-wal-theme` to `~/.config/rofi/wal-theme.rasi`
`wal/templates/zathurarc` to `~/.config/zathura/zathurarc`

If you don't have a desktop notifications handler, make sure to disable desktop notifications in apps such as `discord` that tend to panic if their attempts to send a desktop notification fail.

`config/ranger/plugins/zoxide` is a submodule, so in git's infinite wisdom it doesn't clone the submodule along with the repository. Run `git submodule update --init config/ranger/plugins/zoxide` to fix that.
the `ranger` alias in .zshrc fails if `urxvt` is not installed - installing urxvt will fix ranger's behaviour on alacritty

Installing fonts for polybar:
`sudo cp fonts/*/font/*.ttf /usr/share/fonts/TTF/`
