from flask import Flask
from controllers.publisher_controller import publisher_bp
from controllers.game_controller import game_bp
from controllers.library_controller import library_bp

app = Flask(__name__)

app.register_blueprint(publisher_bp)
app.register_blueprint(game_bp)
app.register_blueprint(library_bp)

if __name__ == '__main__':
    app.run(debug=True, port=5000)
