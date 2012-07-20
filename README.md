# Language Detection (WIP)
This project will outline an N-Gram using the rank order method described (here)<http://www.lrec-conf.org/proceedings/lrec2010/pdf/279_Paper.pdf>, tt is meant to give you the necessary context to understand what is going on and why we are doing things in this way. The system is based on calculating and comparing language profiles of N-gram frequencies. First we use the system to compute N-gram profiles on training data files written in target languages - language profiles. Given a novel document we want to classify, we compute the N-gram profile of this document document profile and compute the distance between the document and language profiles.

# So what exactly is an N-Gram? 

N-Grams is an N-character slice of a longer string. Typically one would slice the string into a set of overlapping N-grams. In our system we will use N-Grams of various lengths simultaneously. We will also append blanks to the beginning and end of strings in order to help with matching the beginning-of-word and end-of-word situations. We will represent this using the _ character. Given the word "TEXT" we would obtain the following N-Grams
  
  bi-grams _T, TE, EX, XT, T_
  tri-grams _TE, TEX, EXT, XT_, T__ 
  quad-grams _TEX, TEXT, EXT_, XT__, T___
  
In general a string of length k, padded with blanks, will have k + 1 bi-grams, k + 1 tri-grams, k + 1 quad-grams and so on.

# How does this all work?

Human language has some words which occur more than others. For example you can imagine that in a document the word the will occur more frequently than the word aardvark. More over there is always a small set of words which dominates most of the language in terms of frequency of use. This is true both for words in a particular language and also for words in a particular category. Thus words which appear in a sporty document will be different from the words that appear in a political document and words which are in the English language will obviously be different from words which are in the French language.
Well it turns out that these small fragments of words (N-grams) also obey (approximately) the same property. Thus given a document in a particular language we will always find a set of N-grams which dominate2 and these set of N-grams will be different for each language. Since we are using small fragments of text we are not very susceptible to noise making our detection more resilient.

# Pre-processing

Generation of the language profiles is easy. Given an input document the following steps need to be performed.

  Split the input document into separate tokens consisting only of letters and apostrophes. Digits and punctuation should be discarded.
Remove any extra spacing and make sure that there is always a letter before a punctuation mark. Thus a. is good while a . is bad

  Spit the document into three parts; train, validation and test in the ratio 0.7, 0.2, and 0.1 respectively. Put the partitioned document into three separate folders; train, validate and test. 
  
  Scan down each token generating all possible N-grams, for N = 1 to 5. Use positions that span the padding blanks as well.  

  Use a hash table to find the counter for the particular N-gram and incrementing it. When done sort the counts in reverse order by the number of occurrences and take the top n N-Grams (limit). The result is the N-gram frequency profile of the language.

# What to expect

From other language detection frameworks implemented we know that we should expect the following results.

  The top 300 or so N-grams are almost always highly correlated to the language. Thus the language model from a sporty document will be very similar to the language model generated from a political document. This gives us confidence that if we train the system on the Declaration of Human Right we will still be able to classify documents to the correct language even though they might have completely different topics.

  The highest ranking N-grams are mostly uni-grams and simply reflect the distribution of characters in a language. After uni-grams N-grams representing prefixes and suffixes should be the most popular.

  Starting at around rank 300 or so an N-gram frequency profile begins to become specific to the topic. We will need to optimise this by training the system.

# How to compare N-gram models

Given that we have create the language profile and also performed the pre-processing steps discussed in Section 4 how do we actually compare two profiles. This step is simple, what we do is we take the document profile and calculate a simple rank-order statistic which we call the “out of place” measure. This measure determines how far out of place an N-gram in one profile is from its place in another profile. For example given the following:

  English Language Profile [TH, ING, ON, ER, AND, ED] 
  Sample Document Profile [TH, ER, ON, LE, ING, AND]

The out-of-place rank would be 0 + 2 + 0 + K + 3 + 17. K represents a fixed cost for an N-gram which is not found.
In order to classify a sample document we compute the overall distance measure between the document profile and the language profile for each language using the out-of-place measure and then pick the language which has the smallest difference. Alternatively we could also rank them and give the ranked results to the user.

# Setup 
 * Bash >= 4
 * Awk


# Run
In order to run the language detection module go to the scripts folder and run 

    ./language_detect.sh <text> <ngram size> <number of ngrams to consider>  | sort -k 2 -n

This will rank a subset of 23 languages with the most likely language first.   This is the result 

E.g. 

    ./language_detect.sh "I really think this should work" 3 1000 | sort -k 2 -n
 
Should output something like

    eng 1999
    lux 5049
    ger 5396
    dut 5836
    dns 6106
    hng 6134
    lit 6697
    frn 6727
    ukr 6879
    ltn1 7052
    yps 7160
    mls 7061
    rum 7388
    por 7390
    ltn 7405
    itn 7406
    rmn1 7454
    spn 7463
    czc 8135
    lat 8241
    jpn 9200
    rus 9200
    grk 9200
    
    