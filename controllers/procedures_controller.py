from flask import Blueprint, request, jsonify
import pymysql
from services.procedures_service import ProceduresService

procedures_bp = Blueprint('procedures', __name__, url_prefix='/api/procedures')
service = ProceduresService()


@procedures_bp.route('/publisher', methods=['POST'])
def insert_publisher_proc():
    try:
        data = request.get_json()
        res = service.insert_publisher(data['name'])
        return jsonify(res), 201
    except pymysql.err.OperationalError as e:
        return jsonify({"db_error": e.args[1]}), 400


@procedures_bp.route('/library', methods=['POST'])
def add_library_proc():
    try:
        data = request.get_json()
        res = service.link_user_and_game(
            nickname=data['nickname'],
            game_name=data['game_name'],
            played_minutes=data.get('played_minutes', 0)
        )
        return jsonify(res), 201
    except pymysql.err.OperationalError as e:
        return jsonify({"db_error": e.args[1]}), 400


@procedures_bp.route('/noname', methods=['POST'])
def insert_noname_proc():
    res = service.generate_10_noname()
    return jsonify(res), 201


@procedures_bp.route('/max-price', methods=['GET'])
def max_price_proc():
    res = service.get_max_game_price()
    return jsonify(res), 200


@procedures_bp.route('/split-publishers', methods=['POST'])
def split_publishers_proc():
    res = service.split_publishers_by_cursor()
    return jsonify(res), 201
