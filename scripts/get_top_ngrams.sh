#!/usr/local/bin/bash
declare -A language_model 
declare -A text_model


export LC_CTYPE=C
if [  $# -ne 4 ]
then
	echo "Usage: <Dataset> <Text> <Ngrams> <Limit>"
	exit 0
fi

function setInArray {
	if [ $3 == 0 ]
	then 
		language_model["$1"]=$2
	else
		text_model["$1"]=$2
	fi
}

# Retrieve the dictionary from the text.  
function getDict {
	TEXT="$1"
	NGRAMS=$2
	LIMIT=$3
	mode=$4

	LANGUAGE_MODEL=$(echo $TEXT | \
		awk '{ print tolower($0) }' | \
		tr -Cd '[[:alpha:]]' | \
		awk -v ngram=$NGRAMS '{for(i = 1; i <= length($0) - (ngram-1); i++)  print substr($0, i, ngram)}' | \
		sort | \
		uniq -ci | \
		sort -n -k 1 -r | \
		awk 'BEGIN {i=0; previous=-1} {if ($1 != previous) {previous = $1; i++}} {print i, $0}' | \
		awk -v limit=$LIMIT '($1<=limit) { print $0 }') 

	while read -r line; 
	do 
		index=`echo "$line" | awk '{print $1}'`
		freq=`echo "$line" | awk '{print $2}'`
		ngram=`echo "$line" | awk '{print $3}'`
		
		# Creating the array
		#echo "Inserted N-Gram: -> $ngram ${model[$ngram]} $index"
		setInArray "$ngram" "$index" $mode 
	done < <( echo "$LANGUAGE_MODEL" )	
}

DATASET=`cat $1`
#echo "Loading Dataset [$1]"
getDict "$DATASET" $3 $4 0

#echo "Creating model for text [$2]"
getDict "$2" $3 $4 1

total=0
# Now let us compare.  
for i in "${!text_model[@]}"
do
	language_index=${language_model[$i]}
	if [ "$language_index" != "" ] 
	then
		text_index=${text_model[$i]}
		difference=$(($language_index - $text_index))
		if [ $difference -le 0 ]
		then
			difference=$(($difference * -1)) 
		fi
		total=$(($total + $difference))
	else
		total=$(($total + 400))
	fi
done
echo "$total"
