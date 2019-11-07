from flask import Flask
from flask import jsonify
from model import Coordinate
app = Flask(__name__)


@app.route("/")
def hello():
    return jsonify({"status": 200})


@app.route("/lab")
def lab():
    coordinates = [
        Coordinate(33.643653, -117.841143),
        Coordinate(33.649985, -117.831387),
        Coordinate(33.687698, -117.771220)
    ]
    coordinates_json = [coordinate.getJSON() for coordinate in coordinates]
    json = {"status": 200, "coordinates": coordinates_json}
    return jsonify(json)


if __name__ == '__main__':
    app.run(debug=True)
