
#!/bin/bash

URL="$1"
SERVER=$(echo "$URL" | cut -d/ -f1-3)

curl -sL "$URL" |
tr -d '\n' |
tr '<' '\n' |
grep -i '^img ' |
sed -nE 's/.*src="([^"]+)".*/\1/p' |
while read LINE
do
    if echo "$LINE" | grep '^https:' > /dev/null
    then
        curl -s -O "$LINE"
    else
        curl -s -O "$SERVER$LINE"
    fi
done

