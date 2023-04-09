#!/bin/bash

content_json="$1"
variables_json="$2"

content=$(echo "$content_json" | jq -r .)

for key in $(echo "$variables_json" | jq -r 'keys[]'); do
  value=$(echo "$variables_json" | jq -r --arg key "$key" '.[$key]')
  content="${content//${key}/${value}}"
done

echo "{\"content\": $(jq -aRs . <<< "$content")}"
