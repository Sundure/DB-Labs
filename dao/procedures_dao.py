from db import get_db_connection


class ProceduresDAO:
    def call_insert_publisher(self, name: str):
        with get_db_connection() as conn:
            with conn.cursor() as cursor:
                cursor.callproc('sp_insert_publisher', (name,))
                return cursor.fetchone()

    def call_add_game_to_library(self, nickname: str, game_name: str, played_minutes: int):
        with get_db_connection() as conn:
            with conn.cursor() as cursor:
                cursor.callproc('sp_add_game_to_user_library',
                                (nickname, game_name, played_minutes))
                return cursor.fetchone()

    def call_insert_10_noname(self):
        with get_db_connection() as conn:
            with conn.cursor() as cursor:
                cursor.callproc('sp_insert_10_noname_publishers')
                return cursor.fetchone()

    def call_get_max_price(self):
        with get_db_connection() as conn:
            with conn.cursor() as cursor:
                cursor.callproc('sp_get_max_game_price')
                return cursor.fetchone()

    def call_split_publishers_cursor(self):
        with get_db_connection() as conn:
            with conn.cursor() as cursor:
                cursor.callproc('sp_split_publishers_cursor')
                return cursor.fetchone()
