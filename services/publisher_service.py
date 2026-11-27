from dao.publisher_dao import PublisherDAO
from dao.game_dao import GameDAO
from dto.dtos import PublisherDTO, GameDTO, PublisherWithGamesDTO


class PublisherService:
    def __init__(self):
        self.publisher_dao = PublisherDAO()
        self.game_dao = GameDAO()

    def get_all_publishers(self):
        rows = self.publisher_dao.get_all()
        return [PublisherDTO(id=r['id'], name=r['name']).to_dict() for r in rows]

    def get_publisher_by_id(self, publisher_id: int):
        row = self.publisher_dao.get_by_id(publisher_id)
        if not row:
            return None
        return PublisherDTO(id=row['id'], name=row['name']).to_dict()

    def create_publisher(self, data: dict):
        new_id = self.publisher_dao.create(data['name'])
        return self.get_publisher_by_id(new_id)

    def update_publisher(self, publisher_id: int, data: dict):
        updated = self.publisher_dao.update(publisher_id, data['name'])
        if not updated:
            return None
        return self.get_publisher_by_id(publisher_id)

    def delete_publisher(self, publisher_id: int):
        return self.publisher_dao.delete(publisher_id)

    def get_publisher_with_games(self, publisher_id: int):
        pub = self.publisher_dao.get_by_id(publisher_id)
        if not pub:
            return None

        game_rows = self.game_dao.get_by_publisher_id(publisher_id)
        games_dto = [
            GameDTO(
                id=g['id'],
                name=g['name'],
                release_date=str(g['release_date']),
                price=g['price'],
                is_available=g['is_available'],
                publisher_id=g['publisher_id']
            ) for g in game_rows
        ]
        return PublisherWithGamesDTO(id=pub['id'], name=pub['name'], games=games_dto).to_dict()
