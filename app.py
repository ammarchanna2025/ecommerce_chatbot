from flask import Flask, render_template, request, jsonify
import json
from flask_cors import CORS
from chat import get_response


app = Flask(__name__, static_folder="static")

CORS(app)

@app.route("/")
def home():
    return render_template("base.html")


@app.route("/predict", methods=["POST"])
def predict():
    text = request.get_json().get("message")
    # Check if JSON is valid
    response = get_response(text)
    message = {"answer": response}
    return jsonify(message)

if __name__=="__main__":
    app.run(debug=True)