from dao.procedures_dao import ProceduresDAO


class ProceduresService:
    def __init__(self):
        self.dao = ProceduresDAO()

    def insert_publisher(self, name: str):
        return self.dao.call_insert_publisher(name)

    def link_user_and_game(self, nickname: str, game_name: str, played_minutes: int):
        return self.dao.call_add_game_to_library(nickname, game_name, played_minutes)

    def generate_10_noname(self):
        return self.dao.call_insert_10_noname()

    def get_max_game_price(self):
        return self.dao.call_get_max_price()

    def split_publishers_by_cursor(self):
        return self.dao.call_split_publishers_cursor()
