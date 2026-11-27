import pymysql
from pymysql.cursors import DictCursor


def get_db_connection():
    return pymysql.connect(
        host='localhost',
        user='flask_user',
        password='1',
        database='mydb',
        charset='utf8mb4',
        cursorclass=DictCursor,
        autocommit=True
    )
