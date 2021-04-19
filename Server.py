from flask import Flask, render_template, jsonify
from flask_restful import Api, Resource, reqparse, abort

app = Flask(__name__)

api = Api(app)

@app.route("/")
def renders_site():
    return render_template("index.html")
    
if __name__ == "__main__":
    app.run(debug=True)

