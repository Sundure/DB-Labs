from flask import Blueprint, jsonify
from services.library_service import LibraryService

library_bp = Blueprint('library', __name__, url_prefix='/api/library')
service = LibraryService()


@library_bp.route('/user/<int:user_id>', methods=['GET'])
def get_user_games(user_id):
    return jsonify(service.get_user_library(user_id)), 200


@library_bp.route('/game/<int:game_id>', methods=['GET'])
def get_game_users(game_id):
    return jsonify(service.get_game_owners(game_id)), 200
