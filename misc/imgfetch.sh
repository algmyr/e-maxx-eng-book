#!/bin/bash

# Move to image folder
cd `dirname "$0"`/../e-maxx-eng/img

grep -hroP 'https?://[^ ]*(png|jpe?g)' ../src |
while read url; do
    wget -nc "$url"
done
