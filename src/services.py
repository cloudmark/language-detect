from sqlalchemy import func, select
from sqlalchemy.orm import aliased
from sqlalchemy.sql.expression import and_
from dao import NGram
from db_manager import DBManager

class LanguageServices(object):
    """
    The Language Services.
    """
    
    def __init__(self):
        self.session = DBManager.get_session()
        self.connection = DBManager.get_connection()
        
    def get_all_ngrams(self):
        """
        Retrieve all the NGrams from the database.
        """
        ngrams = self.session.query(NGram).all()
        return list(ngrams)
        

