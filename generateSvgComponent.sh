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
# base="/home/jkirito/Desktop/testing/scripts"
base=$1;
find $base -name "*.svg" | tee $1ds
input="${base}ds"
# input="${base}/$(ls $1);"
# echo "$input"
while IFS= read -r line
do
  # echo "Content $line"
  # filename="${line:2}"
  filename=$(echo "${line}" | awk -F "/" '/^\// { print $NF }' | cut -f 1 -d '.')
  # filename=$(echo "${filename^}");
  filename=$(echo "${filename^}" | sed 's/.*/\L&/; s/[a-z]*/\u&/g' | sed -e 's/\-//g');
  echo "${filename}"
  content=$(cat "$line" | sed -e 's/width="16"/width={width}/g' -e 's/height="16"/height={height} className={className}/g' -e 's/fill-rule/fillRule/g' -e 's/stroke-opacity/strokeOpacity/g' -e 's/clip-rule/clipRule/g')
  gtemplate="\n \
const $filename = (props: IIcon) => {
  const { width, height, className } = props;
  return (
  $content
)
}
";

printf "$gtemplate" >> index.tsx;
done < "$input"
rm $1ds;
