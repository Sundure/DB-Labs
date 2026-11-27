from dao.game_dao import GameDAO
from dto.dtos import GameDTO


class GameService:
    def __init__(self):
        self.game_dao = GameDAO()

    def _to_dto(self, row: dict):
        return GameDTO(
            id=row['id'],
            name=row['name'],
            release_date=str(row['release_date']),
            price=row['price'],
            is_available=row['is_available'],
            publisher_id=row['publisher_id']
        ).to_dict()

    def get_all_games(self):
        return [self._to_dto(r) for r in self.game_dao.get_all()]

    def get_game_by_id(self, game_id: int):
        row = self.game_dao.get_by_id(game_id)
        return self._to_dto(row) if row else None

    def create_game(self, data: dict):
        new_id = self.game_dao.create(
            name=data['name'],
            release_date=data['release_date'],
            price=data.get('price', 0),
            is_available=data.get('is_available', 1),
            publisher_id=data['publisher_id']
        )
        return self.get_game_by_id(new_id)

    def update_game(self, game_id: int, data: dict):
        updated = self.game_dao.update(
            game_id=game_id,
            name=data['name'],
            price=data['price'],
            is_available=data['is_available']
        )
        return self.get_game_by_id(game_id) if updated else None

    def delete_game(self, game_id: int):
        return self.game_dao.delete(game_id)
