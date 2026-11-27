from db import get_db_connection


class GameDAO:
    def get_all(self):
        with get_db_connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute("SELECT * FROM game")
                return cursor.fetchall()

    def get_by_id(self, game_id: int):
        with get_db_connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute("SELECT * FROM game WHERE id = %s", (game_id,))
                return cursor.fetchone()

    def get_by_publisher_id(self, publisher_id: int):
        with get_db_connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute(
                    "SELECT * FROM game WHERE publisher_id = %s", (publisher_id,))
                return cursor.fetchall()

    def create(self, name: str, release_date: str, price: int, is_available: int, publisher_id: int):
        with get_db_connection() as conn:
            with conn.cursor() as cursor:
                sql = """
                    INSERT INTO game (name, release_date, price, is_available, publisher_id)
                    VALUES (%s, %s, %s, %s, %s)
                """
                cursor.execute(sql, (name, release_date, price,
                               is_available, publisher_id))
                return cursor.lastrowid

    def update(self, game_id: int, name: str, price: int, is_available: int):
        with get_db_connection() as conn:
            with conn.cursor() as cursor:
                sql = "UPDATE game SET name = %s, price = %s, is_available = %s WHERE id = %s"
                cursor.execute(sql, (name, price, is_available, game_id))
                return cursor.rowcount > 0

    def delete(self, game_id: int):
        with get_db_connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute("DELETE FROM game WHERE id = %s", (game_id,))
                return cursor.rowcount > 0
