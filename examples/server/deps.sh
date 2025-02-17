#!/bin/bash
# Download and update deps for binary

# get the directory of this script file
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
PUBLIC=$DIR/public

echo "download js bundle files"
curl https://npm.reversehttp.com/@preact/signals-core,@preact/signals,htm/preact,preact,preact/hooks > $PUBLIC/index.js
echo >> $PUBLIC/index.js # add newline

FILES=$(ls $PUBLIC)

for FILE in $FILES; do
  func=$(echo $FILE | tr '.' '_')
  echo "generate $FILE.hpp ($func)"
  xxd -n $func -i $PUBLIC/$FILE > $DIR/$FILE.hpp
done
