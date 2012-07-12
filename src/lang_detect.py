import sys
import argparse
import textwrap
from db_manager import DBManager
from services import LanguageServices

# ====================================================================================
# Language Detection v1.0.0
#
# This is the Language Detection Module using Language Profile Rank Order Distance.
# ====================================================================================


if __name__ == '__main__':
    # Setup the database.
    DBManager.setup()
    
    # Configure the parser.  
    parser = argparse.ArgumentParser(formatter_class=argparse.RawDescriptionHelpFormatter, 
                                     description=textwrap.dedent("""\
    Language Detection v1.0
    =============================================================================
    These are the available commands.   
        train_file = Train the language detector with the data from the file. The file name will become the language key.
        train_folder = Train the language detector with the data from the folder. The file names will become the language keys.
        test = Test the string with the language models.
        get_n_grams = Retrieve a list of n-grams.
        get_languages = Get a list of languages which can be detected.
        """))

    parser.add_argument('command', choices = ["train_file", \
                                              "train_folder", \
                                              "test", \
                                              "get_n_grams", \
                                              "get_language"],
                                    help=("Select one of the commands outlined in the initial program description. "))
      

    parser.add_argument('min_gram', type=int, help="The minimum number of NGrams to consider for the language model. ", default=1, nargs="?")
    parser.add_argument('max_gram', type=int, help="The maximum number of NGrams to consider for the language model. ", default=5, nargs="?")
    parser.add_argument('limit', type=int, help="The number of NGrams to consider for the language model.  ", default=400, nargs="?")
    
    # Parse the arguments.  
    args = parser.parse_args()
    command = args.command
    min_gram = args.min_gram
    max_gram = args.max_gram
    limit = args.limit
    
    print "= [ Configuration ] ="
    print "\t Min N-Gram: %s" % min_gram
    print "\t Max N-Gram: %s" % max_gram
    print "\t Limit: %s" % limit


    try: 
        print "Training Text File: [%s]" % trf_filename
    except Exception as detail: 
        print "An error has occurred while opening file [%s]. Detail [%s].  " % (trf_filename, detail)
        sys.exit(-1);
    
    
    # Initialize the service layer.  
    services = LanguageServices()
    
    try: 
        commands = {
                        "train_file": services.get_all_ngrams,
                        "train_folder": services.get_all_ngrams,
                        "test": services.get_all_ngrams,
                        "get_n_grams": services.get_all_ngrams,
                        "get_language": services.get_all_ngrams
                    }
        
        if commands.has_key(command): 
            ptr = commands[command](); 
        else:
            print "Command not recognized.  Please refer to the manual for valid commands.  "
            print parser.usage
            
    except Exception as detail: 
        print "An error has occurred whilst executing the command [%s]. Detail [%s].  " % (command, detail)
    
