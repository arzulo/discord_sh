#!/bin/sh


# Input parameter is expecting the path to the bot folder location
# Ex: "/home/zane/discord/takoyaki_bot"
# Ex: "~/discord/takoyaki_bot"

# Main path for NODEJS
NODE_PATH=$(which node)

for var in "$@"
do
	BOT_PATH=$var
	echo "Starting bot at path $BOT_PATH"
	# Setting up the location path
	# BOT_PATH=/root/discord_bots/$BOT_NAME
	BOT_NAME=$(echo "${BOT_PATH##*/}")
	cd $BOT_PATH
	
	# Create a daemon for this bot
	echo "Creating screen daemon named $BOT_NAME"
	screen -dmS $BOT_NAME $NODE_PATH $BOT_PATH/index.js
done
