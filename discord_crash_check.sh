#!/bin/sh

# Setup the base folder for where the bots and scripts sit
# It is assumed that the `discord_sh` directory is at the same level as your `discord_bots` directory
# `DISCORD_BOTS_FOLDER_NAME` is a folder containing several sub-folders of individual node.js based discord bots
# 			-- default name for this folder is `discord_bots`
#BOTS_PATH=/home/arzulo/Dropbox/discord_bots
USER=$(whoami)
DISCORD_BOTS_FOLDER_NAME="discord_bots"
if [ "$USER" = "root" ]; then
	DISCORD_RESOURCES_PATH=/$USER/discord
else
	DISCORD_RESOURCES_PATH=/home/$USER/discord
fi
DISCORD_RESOURCES_PATH=/home/$USER/discord
BOTS_PATH=$DISCORD_RESOURCES_PATH/$DISCORD_BOTS_FOLDER_NAME
SCRIPTS_PATH=$DISCORD_RESOURCES_PATH/discord_sh

##//BOTS_PATH=/$USER/home/discord/discord_bots
##//SCRIPTS_PATH=/$USER/home/discord/discord_bots
##//BOT_SH=/root/discord_bots/discord_sh

# force reset
FORCE_RESET=${1-0}

# Loop through each bot directory, look for its screen name and restart if it's not active
# Bots are assumed to end in a folder directory named `_bot`
for dir in $BOTS_PATH/*
do
	BASENAME=$(basename $dir)
	CURR_BOT_PATH=$BOTS_PATH/$BASENAME
	# if ! screen -list | grep -q "$BASENAME"
	if [ $FORCE_RESET -eq 1 ]; then
		echo "Killing screen $BASENAME"
		screen -S $BASENAME -X quit
	fi
	screen -list | grep -q "$BASENAME"
	if [ $? -ne 0 ] 
		 then
			 echo "$BASENAME isn't up, probably a crash?.  Starting bot back up"
			# /bin/bash $SCRIPTS_PATH/start_bot.sh $BASENAME
			/bin/bash $SCRIPTS_PATH/start_bot.sh $CURR_BOT_PATH
		else
			echo "$BASENAME is online"
	fi
done
