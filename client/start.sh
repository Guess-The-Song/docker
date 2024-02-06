#!/bin/bash

cd /app/client
echo "{\"clientId\": \"${CLIENT_ID}\", \"redirectUrl\": \"${REDIRECT_URI}\", \"serverUrl\": \"${SERVER_URL}\"}" > /app/client/assets/config.json
npx nuxt build
node .output/server/index.mjs