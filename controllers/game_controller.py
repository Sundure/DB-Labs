from flask import Blueprint, request, jsonify
from services.game_service import GameService

game_bp = Blueprint('game', __name__, url_prefix='/api/games')
service = GameService()


@game_bp.route('', methods=['GET'])
def get_all():
    return jsonify(service.get_all_games()), 200


@game_bp.route('/<int:game_id>', methods=['GET'])
def get_one(game_id):
    res = service.get_game_by_id(game_id)
    return (jsonify(res), 200) if res else (jsonify({"error": "Not found"}), 404)


@game_bp.route('', methods=['POST'])
def create():
    data = request.get_json()
    res = service.create_game(data)
    return jsonify(res), 201


@game_bp.route('/<int:game_id>', methods=['PUT'])
def update(game_id):
    data = request.get_json()
    res = service.update_game(game_id, data)
    return (jsonify(res), 200) if res else (jsonify({"error": "Not found"}), 404)


@game_bp.route('/<int:game_id>', methods=['DELETE'])
def delete(game_id):
    deleted = service.delete_game(game_id)
    return (jsonify({"message": "Deleted"}), 200) if deleted else (jsonify({"error": "Not found"}), 404)
