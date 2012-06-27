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

    ./language_detect.sh "I really think this should work" 3 1000 | sort -k 2 -n
 
This will rank a subset of 23 languages with the most likely language first.   
