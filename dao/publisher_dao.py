from db import get_db_connection


class PublisherDAO:
    def get_all(self):
        with get_db_connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute("SELECT * FROM publisher")
                return cursor.fetchall()

    def get_by_id(self, publisher_id: int):
        with get_db_connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute(
                    "SELECT * FROM publisher WHERE id = %s", (publisher_id,))
                return cursor.fetchone()

    def create(self, name: str):
        with get_db_connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute(
                    "INSERT INTO publisher (name) VALUES (%s)", (name,))
                return cursor.lastrowid

    def update(self, publisher_id: int, name: str):
        with get_db_connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute(
                    "UPDATE publisher SET name = %s WHERE id = %s", (name, publisher_id))
                return cursor.rowcount > 0

    def delete(self, publisher_id: int):
        with get_db_connection() as conn:
            with conn.cursor() as cursor:
                cursor.execute(
                    "DELETE FROM publisher WHERE id = %s", (publisher_id,))
                return cursor.rowcount > 0
