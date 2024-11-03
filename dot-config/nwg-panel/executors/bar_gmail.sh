#!/usr/bin/bash

# {"text": "\uf0e0 2", "class": ["unread"]}
output_json=$(bar-gmail)

# Parse json. If class is unread, return the text, otherwise return an empty string
if [[ $(jq -r '.class[0]' <<< "$output_json") == "unread" ]]; then
    jq -r '.text' <<< "$output_json"
else
    echo ""
fi
