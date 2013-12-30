#!/bin/bash
TMP=$(cat $1)
for MATCH in $(sed -n 's/require "\([[:alnum:]\.]*\)"/\1/p' $1)
do
	line=$(echo "$TMP" | grep -n ".*require \"$MATCH\"" | cut -f1 -d:)
	indent=$(echo "$TMP" | sed -n "${line}p" | sed "s/^\([[:space:]]*\)require \"$MATCH\"/\1/")
	filename=$(echo "$MATCH" | sed "s/\./\//g").lua
	TMP=$(echo "$TMP" | head -n $(($line-1));echo "$($0 $filename)" | sed "s/^/$indent/"; echo "$TMP" | tail -n +$(($line+1)) )
done
echo "$TMP"
