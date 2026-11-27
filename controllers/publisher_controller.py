from flask import Blueprint, request, jsonify
from services.publisher_service import PublisherService

publisher_bp = Blueprint('publisher', __name__, url_prefix='/api/publishers')
service = PublisherService()


@publisher_bp.route('', methods=['GET'])
def get_all():
    return jsonify(service.get_all_publishers()), 200


@publisher_bp.route('/<int:publisher_id>', methods=['GET'])
def get_one(publisher_id):
    res = service.get_publisher_by_id(publisher_id)
    return (jsonify(res), 200) if res else (jsonify({"error": "Not found"}), 404)


@publisher_bp.route('/<int:publisher_id>/games', methods=['GET'])
def get_publisher_games(publisher_id):
    res = service.get_publisher_with_games(publisher_id)
    return (jsonify(res), 200) if res else (jsonify({"error": "Not found"}), 404)


@publisher_bp.route('', methods=['POST'])
def create():
    data = request.get_json()
    res = service.create_publisher(data)
    return jsonify(res), 201


@publisher_bp.route('/<int:publisher_id>', methods=['PUT'])
def update(publisher_id):
    data = request.get_json()
    res = service.update_publisher(publisher_id, data)
    return (jsonify(res), 200) if res else (jsonify({"error": "Not found"}), 404)


@publisher_bp.route('/<int:publisher_id>', methods=['DELETE'])
def delete(publisher_id):
    deleted = service.delete_publisher(publisher_id)
    return (jsonify({"message": "Deleted"}), 200) if deleted else (jsonify({"error": "Not found"}), 404)
