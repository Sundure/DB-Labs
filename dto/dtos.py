from dataclasses import dataclass, asdict
from typing import List, Optional


@dataclass
class PublisherDTO:
    id: int
    name: str

    def to_dict(self):
        return asdict(self)


@dataclass
class GameDTO:
    id: int
    name: str
    release_date: str
    price: Optional[int]
    is_available: int
    publisher_id: int

    def to_dict(self):
        return asdict(self)


@dataclass
class PublisherWithGamesDTO:
    id: int
    name: str
    games: List[GameDTO]

    def to_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "games": [g.to_dict() for g in self.games]
        }


@dataclass
class UserGameDTO:
    game_id: int
    game_name: str
    played_minutes: int
    first_played_at: Optional[str]

    def to_dict(self):
        return asdict(self)
