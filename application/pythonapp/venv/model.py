from main import Base, engine
from sqlalchemy import Column, Integer, String
from sqlalchemy.orm import sessionmaker

class Item(Base):
    __tablename__ = "items"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, index=True)
    description = Column(String)

Base.metadata.create_all(bind=engine)