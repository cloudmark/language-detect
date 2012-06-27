#!/bin/bash

# Retrieve the dictionary from the text.  
function getDict {
	declare -a language_model
	TEXT=$1
	NGRAMS=$2
	LIMIT=$3
	LANGUAGE_MODEL=$(echo $TEXT | \
		awk '{ print tolower($0) }' | \
		tr -Cd 'a-zA-Z' | \
		awk -v ngram=$NGRAMS '{for(i = 1; i <= length($0) - (ngram-1); i++)  print substr($0, i, ngram)}' | \
		sort | \
		uniq -ci | \
		sort -n -k 1 -r | \
		awk 'BEGIN {i=0; previous=-1} {if ($1 != previous) {previous = $1; i++}} {print i, $0}' | \
		awk -v limit=$LIMIT '($1<=limit) { print $1,$0 }') 

	
	printf %s "$LANGUAGE_MODEL" | while IFS= read -r line
	do
		index=`echo "$line" | awk '{print $1}'`
		ngram=`echo "$line" | awk '{print $4}'`
		echo "[$line] $index $ngram"
	done
}


export LC_CTYPE=C

if [  $# -ne 4 ]
then
	echo "Usage: <Dataset> <Text> <Ngrams> <Limit>"
	exit 0
fi
DATASET=`cat $1`
echo "Loading Dataset [$1]"
getDict "$DATASET" $3 $4


# getDict $2 $3 $4
