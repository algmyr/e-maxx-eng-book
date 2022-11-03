
#!/bin/bash

# Move to root
cd "$(dirname "$0")/.."

COMMIT_HASH="$(git rev-parse --short HEAD:e-maxx-eng)"
sed "s/LASTCOMMIT/${COMMIT_HASH}/; s#^% CONTENT GOES HERE\$#\\\\input{$1}#" misc/standalone_template.tex

