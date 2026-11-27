from db import get_db_connection


class LibraryDAO:
    def get_games_by_user(self, user_id: int):
        with get_db_connection() as conn:
            with conn.cursor() as cursor:
                sql = """
                    SELECT g.id AS game_id, g.name AS game_name, l.played_minutes, l.first_played_at
                    FROM library l
                    JOIN game g ON l.game_id = g.id
                    WHERE l.user_id = %s
                """
                cursor.execute(sql, (user_id,))
                return cursor.fetchall()

    def get_users_by_game(self, game_id: int):
        with get_db_connection() as conn:
            with conn.cursor() as cursor:
                sql = """
                    SELECT u.id AS user_id, u.nickname, u.email, l.played_minutes
                    FROM library l
                    JOIN user u ON l.user_id = u.id
                    WHERE l.game_id = %s
                """
                cursor.execute(sql, (game_id,))
                return cursor.fetchall()
