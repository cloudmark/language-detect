export LC_CTYPE=C

if [  $# -ne 3 ]
then
	echo "Usage: <File> <Ngrams> <Limit>"
	exit 0
fi


cat $1 | \
	awk '{ print tolower($0) }' | \
	tr -Cd 'a-zA-Z' | \
	awk -v ngram=$2 '{for(i = 1; i <= length($0) - (ngram-1); i++)  print substr($0, i, ngram)}' | \
	sort | \
	uniq -ci | \
	sort -n -k 1 -r | \
	awk 'BEGIN {i=0; previous=-1} {if ($1 != previous) {previous = $1; i++}} {print i, $0}' | \
	awk -v limit=$3 '($1<=limit) { print $1,$0 }' 
