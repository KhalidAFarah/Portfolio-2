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


class UserGetAll(Resource):
    def get(self):
        mycursor.execute("SELECT * FROM Customers")
        response = []
        for user  in mycursor:       
            response.append({"user_id": user[0],"Username":user[1],"Password":user[2],"Email":user[3]})
        response = jsonify(response)
        response.headers.add("Access-Control-Allow-Origin", "*")
        return response

class UserGet(Resource):
    def get(self, Username, Password):
        mycursor.execute("SELECT * FROM Customers WHERE Username = \"{}\" AND Password = \"{}\"".format(Username, Password))
        for user  in mycursor:       
            response = {"user_id": user[0],"Username":user[1],"Password":user[2],"Email":user[3]}
            response = jsonify(response)
            response.headers.add("Access-Control-Allow-Origin", "*")
            return response

        abort(404, message="User not found")

class UserPost(Resource):
    def post(self):
        parser = reqparse.RequestParser()
        parser.add_argument("Username")
        parser.add_argument("Password")
        parser.add_argument("Email")
        data = parser.parse_args()

        mycursor.execute("INSERT INTO Customers (Username, Password, Email) VALUES ({}, {}, {})".format(data['Username'], data['Password'], data['Email']))
        db.commit()

        return 200

api.add_resource(UserGet, "/user/<Username>/<Password>/")
api.add_resource(UserPost, "/user/")
api.add_resource(UserGetAll, "/users/")

class item(Resource):
    def get(self, item_id): # get an item from the db
        pass
class itemPost(Resource):
    def post(self): # add an item to the db (admin)
        pass


api.add_resource(item, "/item/<int:item_id>/")
api.add_resource(itemPost, "/item/")
    


    
if __name__ == "__main__":
    app.run(debug=True)

