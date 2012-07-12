from sqlalchemy import Column, Integer, String
from db_manager import DBManager

class NGram(DBManager.Base):
    """
    NGrams represent the language profile of a particular language.
    """
    __tablename__ = 'ngram'

    id = Column(Integer, autoincrement=True, primary_key=True)
    language_code = Column(String, nullable=False)
    ngram = Column(String, nullable=False)
    frequency = Column(Integer, nullable=False)
    length = Column(Integer, nullable=False)

    def __init__(self, language_code, ngram, frequency, length):
        self.language_code=language_code
        self.ngram=ngram
        self.frequency=frequency
        self.length=length

    def __str__(self):
        return "[%s] %s %d" % (self.language_code, self.ngram, self.frequency)
        
