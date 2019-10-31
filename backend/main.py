from flask import Flask
from flask import jsonify
app = Flask(__name__)


@app.route("/")
def hello():
    return jsonify({"status": 200})


if __name__ == '__main__':
    app.run(debug=True)
