#!/bin/bash

# Move to root
cd `dirname "$0"`/..

TEMPFILE=$(mktemp) && (
while read line; do
    if [[ "$line" == "###"* ]]; then
        echo "$line" | sed -E 's/### (.*)/\\part{\1}/' >> $TEMPFILE
    elif [[ "$line" == "- **"* ]]; then
        echo "$line" | sed -E 's/- \*\*(.*)\*\*/\\chapter{\1}/' >> $TEMPFILE
    elif [[ "$line" == "- "* ]]; then
        cat $(echo "$line" | sed -E 's!- \[.*\]\(./(.*).html\)!e-maxx-eng/src/\1.tex!') >> $TEMPFILE
    fi
done < e-maxx-eng/src/index.md



sed '/^% CONTENT GOES HERE$/r'$TEMPFILE <(sed "s/LASTCOMMIT/$(git rev-parse --short HEAD:e-maxx-eng)/" misc/template.tex)
rm $TEMPFILE
)
