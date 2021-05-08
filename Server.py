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
@app.route("/Login/")
def renders_site():
    return render_template("index.html")

@app.route("/Register/")
def renders_site_register():
    return render_template("Register.html")    

#Rendering the base site
@app.route("/admin/")
def renders_site_admin():
    return render_template("addProduct.html")
    
#Rendering the shopping cart site
@app.route("/cart/")
def renders_site_cart():
    return render_template("shoppingcart.html")

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

    query="Select Name, Price, Image FROM Products WHERE Name LIKE \"%{}%\"".format(searchbox)
    mycursor.execute(query)
    result = mycursor.fetchall()
    return jsonify(result)

@app.route("/<int:Product_id>/")
def itemPage(Product_id):
    return render_template("item.html")




class UserGetAll(Resource):
    def get(self):
        mycursor.execute("SELECT User_id, Firstname, Lastname, Email FROM Customers")
        response = []
        for user  in mycursor:       
            response.append({"user_id": user[0], "Firstname":user[1],"Lastname":user[2],"Username":user[3],"Email":user[4]})
        response = jsonify(response)
        response.headers.add("Access-Control-Allow-Origin", "*")
        return response

class UserGet(Resource):
    def get(self, Username, Password):
        mycursor.execute("SELECT User_id, Firstname, Lastname, Username, Email FROM Customers WHERE Username = \"{}\" AND Password = \"{}\"".format(Username, Password))
        for user  in mycursor:       
            response = {"user_id": user[0],"Firstname":user[1],"Lastname":user[2],"Username":user[3],"Email":user[4]}
            response = jsonify(response)
            response.headers.add("Access-Control-Allow-Origin", "*")
            return response

        abort(404, message="User not found")

class UserPost(Resource):
    def post(self):
        parser = reqparse.RequestParser()
        parser.add_argument("Firstname")
        parser.add_argument("Lastname")
        parser.add_argument("Username")
        parser.add_argument("Password")
        parser.add_argument("Email")
        data = parser.parse_args()

        try:
            mycursor.execute("INSERT INTO Customers (Firstname, Lastname, Username, Password, Email) VALUES (%s, %s, %s, %s, %s)",(data['Firstname'], data['Lastname'] ,data['Username'], data['Password'], data['Email']))
            db.commit()
        except:
           abort(401, message = "Username or password is already taken.")
        url = request.url.split("/")[0]
        return redirect(url+"/Login/")


api.add_resource(UserGet, "/user/<Username>/<Password>/")
api.add_resource(UserPost, "/user/")
api.add_resource(UserGetAll, "/users/")

class item(Resource):
    def get(self, Product_id): # get an item from the db
        #try:
        #    print(Product_id)
        mycursor.execute("SELECT * FROM Products WHERE Product_id={}".format(int(Product_id)))
       # except:
       #     abort(404, message="product not found")
        response =  {}
        for product in mycursor:
            item = {
                "Product_id":product[0],
                "Category_id":product[1],
                "Name":product[2],
                "Price":product[3],
                "Image":product[4],
                "Description":product[5],
                "Specification":product[6]
            }
            response[product[0]] = item

        response = jsonify(response)
        response.headers.add("Access-Control-Allow-Origin", "*")
        return response

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
            if image.filename:
                print("sd")
                image.save(os.path.join(os.getcwd() + "/Portfolio-2/static/Pictures/", image.filename))

                mycursor.execute("INSERT INTO Products (Name, Price, Image, Category_id, Description, Specification) VALUES (%s, %s, %s, %s, %s, %s)",(data['Name'], int(data['Price']), image.filename, int(data['Category_id']), data['Description'], data['Specification']))
                db.commit()
            else:
                mycursor.execute("INSERT INTO Products (Name, Price, Image, Category_id, Description, Specification) VALUES (%s, %s, %s, %s, %s, %s)",(data['Name'], int(data['Price']), "placeholder.PNG", int(data['Category_id']), data['Description'], data['Specification']))
                db.commit()

        except:
            abort(401, message = "Product is already registered.")


        url = request.url.split("?")[0].replace("/item/", "/admin/")
        
        return redirect(url)
        

api.add_resource(item, "/item/<int:Product_id>/")
api.add_resource(itemPost, "/item/")
    
class Categories(Resource):
    def get(self): #getting all categories
        mycursor.execute("SELECT * FROM Categories")
        response = {}
        for value in mycursor:
            response[value[0]] = {"Category_id":value[0], "Category":value[1]}
        
        response = jsonify(response)
        response.headers.add("Access-Control-Allow-Origin", "*")
        return response
api.add_resource(Categories, "/Categories/")

class Category(Resource):
    def get(self, Category_id): #getting a category
        try:
            mycursor.execute("SELECT * FROM Categories WHERE Category_id = {}".format(Category_id))
        except:
            abort(404, message="invalid category was given")
        response = {}
        for value in mycursor:
            response[value[0]] = {"Category_id":value[0], "Category":value[1]}
            
        response = jsonify(response)
        response.headers.add("Access-Control-Allow-Origin", "*")
        return response
        
api.add_resource(Category, "/Category/<int:Category_id>/")

class getAllInCategory(Resource):
    def get(self, Category_id):
        mycursor.execute("SELECT * FROM Products WHERE Category_id={}".format(int(Category_id)))
        
        response = {}
        for product in mycursor:

            x = {
                "Product_id":product[0],
                "Category_id":product[1],
                "Name":product[2],
                "Price":product[3],
                "Image":product[4],
                "Description":product[5],
                "Specification":product[6]
            }
            response[product[0]] = x
        
        response = jsonify(response)
        response.headers.add("Access-Control-Allow-Origin", "*")
        return response
api.add_resource(getAllInCategory, "/Sort/<int:Category_id>/")

        



class Cart(Resource):
    def post(self):
        parser = reqparse.RequestParser()
        parser.add_argument("User_id")
        parser.add_argument("Product_id")
        parser.add_argument("Amount")
        
        data = parser.parse_args()
        
        try:
            mycursor.execute("INSERT INTO Carts (User_id, Product_id, Amount, Ordered) VALUES (%s,%s,%s,%s)", (int(data['User_id']), int(data['Product_id']), int(data['Amount']), "No"))
            db.commit()
        except:
            abort(405, message="Unable to add product to cart")

        return 200
    def get(self): #get all in a cart
        parser = reqparse.RequestParser()
        parser.add_argument("User_id")
        data = parser.parse_args()
        mycursor.execute("SELECT Carts.Cart_id, P.Product_id, P.Category_id, P.Name, P.Price, P.Image, P.Description, Carts.Amount FROM Products as P LEFT JOIN Carts ON P.Product_id = Carts.Product_id WHERE User_id={} AND Carts.Ordered=\"No\"".format(data['User_id']))
        
        response = {}
        for product in mycursor:

            x = {
                "Product_id":product[1],
                "Category_id":product[2],
                "Name":product[3],
                "Price":product[4],
                "Image":product[5],
                "Description":product[6],
                "Amount":product[7]
            }
            response[product[0]] = x

        response = jsonify(response)
        response.headers.add("Access-Control-Allow-Origin", "*")
        return response
    
    def delete(self):
        parser = reqparse.RequestParser()
        parser.add_argument("User_id")
        parser.add_argument("Cart_id")
        data = parser.parse_args()
        try:
            mycursor.execute("DELETE FROM Carts WHERE User_id={} AND Cart_id={}".format(int(data['User_id']), int(data['Cart_id'])))
            db.commit()
        except:
            abort(404, message="User og cart does not exist")

        return 200

    def put(self):
        parser = reqparse.RequestParser()
        parser.add_argument("User_id")
        parser.add_argument("Cart_id")
        parser.add_argument("Amount")
        data = parser.parse_args()
        try:
            mycursor.execute("UPDATE Carts SET Amount={} WHERE User_id={} AND Cart_id={}".format(int(data['Amount']), int(data['User_id']), int(data['Cart_id'])))
            db.commit()
        except:
            abort(404, message="Unable to update amount products selected user or cart may not exist")

        return 200
api.add_resource(Cart, "/Cart/")
class Order(Resource):
    def post(self):
        parser = reqparse.RequestParser()
        parser.add_argument("User_id")
        data = parser.parse_args()

        mycursor.execute("SELECT Product_id, Amount FROM Carts WHERE User_id={} AND Ordered=\"No\"".format(int(data['User_id'])))
        results = mycursor.fetchall()

        for Product_id, Amount in results:
            mycursor.execute("INSERT INTO Orders (User_id, Product_id, Amount) VALUES ({},{},{})".format(int(data['User_id']), int(Product_id), int(Amount)))

        mycursor.execute("DELETE FROM Carts WHERE User_id={}".format(int(data['User_id'])))
        db.commit()
        
        return 200




        


api.add_resource(Order, "/Order/")
if __name__ == "__main__":
    app.run(debug=True)

