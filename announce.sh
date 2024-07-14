#!/bin/bash

MOD_NAME=$(jq -r ".name" "$INFO_JSON_FILE")
MOD_VERSION=$(jq -r ".version" "$INFO_JSON_FILE")
CHANGELOG_TEXT="${MOD_NAME} ${MOD_VERSION} has been released. Changelog:"$'\n'"$(sed -n '/\-\{99,\}/{n; p; :loop n; /\-\{99,\}/q; p; b loop}' ${CHANGELOG_FILE} | sed 's/\(.*\)/> &/')"

curl -H 'Content-Type: multipart/form-data' --form-escape -F username="${MOD_NAME}" -F content="${CHANGELOG_TEXT}" $DISCORD_WEBHOOK
