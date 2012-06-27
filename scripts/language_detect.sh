#!/usr/local/bin/bash
if [  $# -ne 3 ]
then
	echo "Usage: <Text> <Ngrams> <Limit>"
	exit 0
fi
# The directory from where to pick the language exemplars.  
LANG_DIR='../data/udhr/subset/'
# Length of ngrams
NGRAMS=$2
# How many n-grams should we get.  
LIMIT=$3

for dir in `ls -1 $LANG_DIR`
do
	language=`basename $dir`
	language=${language/.txt/}
	full_path=$LANG_DIR""$dir
	score=`./get_top_ngrams.sh "$full_path" "$1" $NGRAMS $LIMIT`
	echo $language $score
done
