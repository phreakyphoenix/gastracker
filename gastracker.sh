#!/bin/bash

TELEGRAM_BOT_TOKEN="TELEGRAM TOKEN"    # like "7149217724:AAHTHbdTF1dKz1bb5MM1rfPsQoYXFV_Z7lA"
TELEGRAM_CHAT_ID="chat_id"    #like "641085312"
ETH_API_URL="https://api.etherscan.io/api?module=gastracker&action=gasoracle&apikey=XPX16IR4EEFJ4HKQB6GDDUJMEF3VN2RKQW"  #change api key param

# Get SafeGasPrice using curl and jq
SAFE_GAS_PRICE=$(curl -s "$ETH_API_URL" | jq -r '.result.SafeGasPrice')

# Check if SafeGasPrice is less than 30
if [ "$SAFE_GAS_PRICE" -lt 100 ]; then
    MESSAGE="SafeGasPrice is less than 30: $SAFE_GAS_PRICE"
    
    # Send Telegram message
    curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
        -d "chat_id=$TELEGRAM_CHAT_ID" \
        -d "text=$MESSAGE"

    echo "Telegram message sent: $MESSAGE"
fi
