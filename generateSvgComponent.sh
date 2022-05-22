#!/bin/bash

content="$(cat folder.svg)"
# echo "$content"

#search pattern
# find . -name '*.svg' -exec cat {} \; | sed -n '/svg/p'

#replace words
# find . -name '*.svg' -exec cat {} \; | sed 's/svg/tmp/g'

# find . -name '*.svg' -exec cat {} \; | sed 's/^/Component /' 
# echo "$find"

rm -f index.tsx
touch index.tsx
base="/home/jkirito/Desktop/testing/scripts"
find $base -name "*.svg" > ds
input="${base}/ds"
# input="${base}/$(ls $1);"
# echo "$input"
while IFS= read -r line
do
  # echo "Content $line"
  # filename="${line:2}"
  filename=$(echo "${line}" | awk -F "/" '/^\// { print $NF }' | cut -f 1 -d '.')
  filename=$(echo "${filename^}");
  echo "${filename}"
  content=$(cat "$line")
  gtemplate="\n \
const $filename = () => {\n \
  return (\n \
  $content \n \
)\n \
}\n \
";

printf "$gtemplate" >> index.tsx;
done < "$input"
rm ds;
