#!/usr/bin/env bash
set -e

rsync --recursive --delete --ignore-existing --compress exodus.mc4wp.com:~/backups/ ~/backups/exodus.mc4wp.com
rsync --recursive --delete --ignore-existing --compress exodus.boxzillaplugin.com:~/backups/ ~/backups/exodus.boxzillaplugin.com
rsync --recursive --delete --ignore-existing --compress genesis.dvk.co:~/backups/ ~/backups/genesis.dvk.co