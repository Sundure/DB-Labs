from dao.library_dao import LibraryDAO
from dto.dtos import UserGameDTO


class LibraryService:
    def __init__(self):
        self.library_dao = LibraryDAO()

    def get_user_library(self, user_id: int):
        rows = self.library_dao.get_games_by_user(user_id)
        return [
            UserGameDTO(
                game_id=r['game_id'],
                game_name=r['game_name'],
                played_minutes=r['played_minutes'],
                first_played_at=str(r['first_played_at']
                                    ) if r['first_played_at'] else None
            ).to_dict()
            for r in rows
        ]

    def get_game_owners(self, game_id: int):
        # Тут можна повернути словник напряму або через UserOwnerDTO
        return self.library_dao.get_users_by_game(game_id)
