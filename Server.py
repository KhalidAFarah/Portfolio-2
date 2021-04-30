from flask import Flask, render_template, jsonify, request, redirect
from flask_restful import Api, Resource, reqparse, abort
import mysql.connector
import os

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

#Rendering the base site
@app.route("/admin/")
def renders_site_admin():
    return render_template("addProduct.html")

#status for restAPI
@app.route("/status", methods=['GET'])
def status():
    response = jsonify({"Status": "Ok"})
    response.headers.add("Access-Control-Allow-Origin", "*")
    return response



@app.route("/")
def front_page():
    return render_template("./front_page.html")

@app.route("/livesearch",methods=["POST","GET"])
def livesearch():
    searchbox = request.form.get("text")#getting the request from the value
    cursor = mysql.connection.cursor()
    query="Select word Like '{}%".format(searchbox)
    cursor.execute(query)
    result = cursor.fetchall()
    return jsonify(result)


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

        try:
            mycursor.execute("INSERT INTO Customers (Username, Password, Email) VALUES ({}, {}, {})".format(data['Username'], data['Password'], data['Email']))
            db.commit()
        except:
            abort(401, message = "Username or password is already taken.")

        return 200

api.add_resource(UserGet, "/user/<Username>/<Password>/")
api.add_resource(UserPost, "/user/")
api.add_resource(UserGetAll, "/users/")

class item(Resource):
    def get(self, item_id): # get an item from the db
        pass
class itemPost(Resource):
    def post(self): # add an item to the db (admin)
        parser = reqparse.RequestParser()
        

        

        parser.add_argument("Name")
        parser.add_argument("Price")
        parser.add_argument("Category_id")
        parser.add_argument("Description")
        parser.add_argument("Specification")

        data = parser.parse_args()
        
        try:   
            image = request.files['pictures']
            if image.filename !=  "":
                image.save(os.path.join(os.getcwd() + "/Portfolio-2/static/Pictures/", image.filename))

                mycursor.execute("INSERT INTO Products (Name, Price, Image, Category_id, Description, Specification) VALUES (%s, %s, %s, %s, %s, %s)",(data['Name'], int(data['Price']), image.filename, int(data['Category_id']), data['Description'], data['Specification']))
                db.commit()
            else:
                mycursor.execute("INSERT INTO Products (Name, Price, Category_id, Description, Specification) VALUES (%s, %s, %s, %s, %s)",(data['Name'], int(data['Price']), int(data['Category_id']), data['Description'], data['Specification']))
                db.commit()

        except:
            abort(401, message = "Product is already registered.")


        url = request.url.split("?")[0].replace("/item/", "/admin/")
        
        return redirect(url)
        

api.add_resource(item, "/item/<int:item_id>/")
api.add_resource(itemPost, "/item/")
    
class Categories(Resource):
    def get(self): #getting all categories
        mycursor.execute("SELECT * FROM Categories")
        response = {}
        for value in mycursor:
            response[value[0]] = value[1]
        
        response = jsonify(response)
        response.headers.add("Access-Control-Allow-Origin", "*")
        return response
api.add_resource(Categories, "/Categories/")


    
if __name__ == "__main__":
    app.run(debug=True)

