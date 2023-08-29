#!/bin/bash

# Move to image folder
readonly IMG_PATH="$(dirname "$0")/../e-maxx-eng/static/img"
mkdir -p "${IMG_PATH}"
cd "${IMG_PATH}"

grep -hroE 'https?://[^ ]*(png|jpe?g)' ../../src |
while read url; do
    wget -nc "$url"
done
