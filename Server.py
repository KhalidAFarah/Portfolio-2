from flask import Flask, render_template, jsonify
from flask_restful import Api, Resource, reqparse, abort
import mysql.connector

app = Flask(__name__)
api = Api(app)
db = mysql.connector.connect(
    host="127.0.0.1",
    user="general",
    passwd="general",
    database="Webshop",
    auth_plugin="mysql_native_password"
    )

mycursor = db.cursor()

mycursor.execute("SHOW TABLES")
for x in mycursor:
    print(x)


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

class UserGet(Resource):
    def get(self, user_id):
        pass
class UserPost(Resource):
    def post(self):
        pass

api.add_resource(UserGet, "/user/<int:user_id>/")
api.add_resource(UserPost, "/user/")

class item(Resource):
    def get(self, item_id): # get an item from the db
        pass
class itemPost(Resource):
    def post(self): # add an item to the db (admin)
        pass


api.add_resource(item, "/item/<int:item_id>/")
api.add_resource(itemPost, "/item/")
    


    
if __name__ == "__main__":
    #app.run(debug=True)
    pass

