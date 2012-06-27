Language Detection Experiments
==============================

Language detection experiments to investigate the area of language detection.  Currently the scripts are written in Bash and awk, these will be later be implemented in python once we find an optimal soluation. 


Setup 
======
 * Bash >= 4
 * Awk

Algorithms
==========
  * The Ranking Algorithm <http://www.lrec-conf.org/proceedings/lrec2010/pdf/279_Paper.pdf>
  * Probabilistic models coming soon.  

Run
===

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
    
    