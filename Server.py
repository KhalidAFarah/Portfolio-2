from flask import Flask, render_template, jsonify
from flask_restful import Api, Resource, reqparse, abort

app = Flask(__name__)

api = Api(app)

#Rendering the base site
@app.route("/")
def renders_site():
    return render_template("index.html")

#status for restAPI
@app.route("/status", methods=['GET'])
def status():
    response = jsonify({"Status": "Ok"})
    response.headers.add("Access-Control-Allow-Origin", "*")
    return response

class item(Resource):
    def get(self): # get an item from the db
        pass
class itemPost(Resource):
    def post(self): # add an item to the db (admin)
        pass


api.add_resource(item, "/item/<int:itemId>/")
api.add_resource(itemPost, "/item/")
    


    
if __name__ == "__main__":
    app.run(debug=True)

