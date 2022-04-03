#!/bin/sh
# Currently unused, not very helpful...

#NODE_PATH=/home/arzulo/.nvm/versions/node/v12.6.0/bin/node
NODE_PATH=/usr/bin/node

for var in "$@"
do
	BOT_NAME=$var
	# Setting up the location path
	BOT_PATH=/root/discord_bots/$BOT_NAME
	cd $BOT_PATH

	echo "Killing screen $BOT_NAME"
	screen -X -S $BOT_NAME quit

	echo "Starting bot $BOT_NAME"
	# Create a daemon for this bot
	screen -dmS $BOT_NAME $NODE_PATH $BOT_PATH/index.js
done
