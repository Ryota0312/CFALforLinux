#!/bin/bash
/usr/local/bin/fswatch your_home_dir --exclude ".*\/\..*\/.*" --exclude "access_log" --format "%t,%p,%f" --format-time "%FT%T" -r --allow-overflow --event Created --event Updated --event Removed --event Renamed --event MovedFrom --event MovedTo
