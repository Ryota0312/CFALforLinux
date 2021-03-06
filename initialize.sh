#!/bin/bash
if [ ! -e "config.sh" ]; then
    echo "####### config.sh is not exist #######"
    echo "Please create config.sh by copying config.sample.sh"
    exit 1
fi

if [ ! -x "config.sh" ]; then
    chmod +x config.sh
fi

source config.sh

fswatch_path=`which fswatch`

sed -e "s&your_CFAL_path&${YOUR_CFAL_DIR}&g" templates/collect_file_access_log.sh.tpl | sed -e "s&your_home_dir&${YOUR_HOME_DIR}&g" | sed -e "s&your_ignore_list&${YOUR_IGNORE_LIST}&g"  | sed -e "s&FSWATCH_PATH&${fswatch_path}&g" > collect_file_access_log.sh

if [ "$(uname -s)" == 'Linux' ]; then
    # for Linux
    sed -e "s&your_CFAL_path&${YOUR_CFAL_DIR}&g" templates/collect_file_access_log.service.tpl > collect_file_access_log.service
    cp collect_file_access_log.service ~/.config/systemd/user/
elif [ "$(uname)" == 'Darwin' ]; then
    # for Mac OS X
    sed -e "s&your_CFAL_path&${YOUR_CFAL_DIR}&g" templates/collect_file_access_log.plist.tpl > collect_file_access_log.plist
    cp collect_file_access_log.plist ~/Library/LaunchAgents/
fi

if [ ! -x "collect_file_access_log.sh" ]; then
    chmod +x collect_file_access_log.sh
fi

touch access_log
touch error_log

