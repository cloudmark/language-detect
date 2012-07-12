from sqlalchemy.engine import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm.session import sessionmaker

class DBManager(object):
    """
    The Database Manager.
    """
    Engine = None
    Base = declarative_base()
    Session = sessionmaker()
    
    @staticmethod
    def setup():
        engine = DBManager.Engine = create_engine('sqlite:///langdetect.db', echo=False)
        DBManager.Base.metadata.create_all(engine)
        DBManager.Session.configure(bind=engine)
        
    @staticmethod
    def get_session():
        return DBManager.Session()
    
    @staticmethod
    def get_connection():
        return DBManager.Engine.connect()