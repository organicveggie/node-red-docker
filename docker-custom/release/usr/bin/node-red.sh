#!/bin/bash
set -ex

NRUID=${NRUID:-1000}
NRGID=${NRGID:-1000}

groupmod -o -g "$NRGID" node-red
usermod -o -u "$NRUID" node-red

echo "
**New**
User uid:    $(id -u node-red)
User gid:    $(id -g node-red)
-------------------------------------
"

chown node-red:node-red /data

exec /bin/su -c "npm start --cache /data/.npm -- --userDir /data" - node-red
