from flask import Flask, render_template, jsonify, request, redirect, send_file
from flask_restful import Api, Resource, reqparse, abort
import mysql.connector
import time
import os


#sdsds
from google.oauth2 import id_token
from google.auth.transport import requests as greq

client_id = "952836639002-aejo8mld9o48v0rrqnruo4jbuisgas2b.apps.googleusercontent.com"
#from prometheus_flask_exporter import PrometheusMetrics

#app = Flask(__name__)
app = Flask(__name__, static_folder="/var/site/", static_url_path="")
api = Api(app)
#metrics = PrometheusMetrics(app)
db = None
while db is None:
    try:
        db = mysql.connector.connect(
            #host="127.0.0.1", #comment out for docker
            host="db", #leave in for docker
            user="general",
            passwd="general",
            database="Webshop",
            #auth_plugin="mysql_native_password" #comment out for docker
        )
    except:
        print("unable to connect to MySQL database waiting retrying in 5 seconds")
        time.sleep(5)


#mycursor = db.cursor()

counter = {
    'getitem': 0,
    'addtocart': 0,
    'orderitem': 0,
    'loggedin':0
}

#CPU usage
#Memory usage


@app.route("/CSS/<filename>/")
def get_CSS(filename):
    return send_file(os.path.join("./static/" ,filename), mimetype='text/css')
@app.route("/JS/<filename>/")
def get_JS(filename):
    return send_file(os.path.join("./static/" ,filename), mimetype='js')
@app.route("/img/<filename>/")
def get_Image(filename):
    return send_file(os.path.join("./static/Pictures/",filename), mimetype='image/jpg/png')

#Rendering the base site
@app.route("/Login/")
def renders_site():
    return render_template("index.html")

@app.route("/category/<catid>/")
def renders_site_category(catid):
    return render_template("category.html")    

@app.route("/Register/")
def renders_site_register():
    return render_template("Register.html")    

#Rendering the admin sites
@app.route("/admin/")
def renders_site_admin():
    return render_template("adminSite.html")

@app.route("/admin/addProduct/")
def renders_site_admin_product():
    return render_template("addProduct.html")
    
#Rendering the shopping cart site
@app.route("/cart/")
def renders_site_cart():
    return render_template("shoppingcart.html")

#status for restAPI
@app.route("/status/", methods=['GET'])
def server_status():
    return 'Online'

#metrics endpoint for prometheus
@app.route("/metrics")
def server_metrics():
    metrics = ""
    #amount of times user went to the product page
    metrics+= 'product_page_request_total %s\n' %  (counter['getitem'],)
    metrics+= 'item_added_to_cart_request_total %s\n' % (counter['addtocart'],)
    metrics+= 'item_ordered_request_total %s\n' % (counter['orderitem'],)
    metrics+= 'user_logged_in_request_total %s\n'% (counter['loggedin'],)

    mycursor = db.cursor()
    mycursor.execute("SELECT Product_id, SUM(Amount) FROM Carts GROUP BY Product_id ORDER BY SUM(Amount) DESC LIMIT 10")
    result = mycursor.fetchall()
    mycursor.close()
    placement = 1
    for metric in result:
        metrics += "most_popular_carted_items{Product_id=\"%s\", placement=\"%s\"} %s\n" % (metric[0], placement,  metric[1])
        placement+=1

    mycursor = db.cursor()
    mycursor.execute("SELECT Product_id, SUM(Amount) FROM Orders GROUP BY Product_id ORDER BY SUM(Amount) DESC LIMIT 10")
    result = mycursor.fetchall()
    mycursor.close()
    placement = 1
    for metric in result:
        metrics += "most_popular_ordered_items{Product_id=\"%s\", placement=\"%s\"} %s\n" % (metric[0], placement,  metric[1])
        placement+=1

    
    return metrics 

@app.route("/userg/<token>/")
def signIn(token):
    mycursor = db.cursor()
    global counter
    try:
        mycursor.execute("SELECT User_id, Firstname, Lastname, Username, Email, Access_level FROM Customers WHERE Username = \"{}\" AND Email = \"{}\"".format(Username, Email))
    except:
        abort(404, message="User not found")
    result = mycursor.fetchall()
    counter['loggedin']+=1
    mycursor.close()
    if len(result)==0:
         mycursor = db.cursor()

    try:
        mycursor.execute("INSERT INTO Customers (Firstname, Lastname, Username,Email) VALUES (%s, %s, %s, %s,)",(data['Firstname'], data['Lastname'] ,data['Username'],data['Email']))
        db.commit()
    except:
        abort(401, message = "Error happened server was unable to log in")
    mycursor.close()


    mycursor = db.cursor()
    try:
        mycursor.execute("SELECT User_id, Firstname, Lastname, Username, Email, Access_level FROM Customers WHERE Username = \"{}\" AND Email = \"{}\"".format(Username, Email))
    except:
        abort(404, message="User not found")
    result = mycursor.fetchall()
    counter['loggedin']+=1
    mycursor.close()
    for user  in result:       
            response = {"user_id": user[0],"Firstname":user[1],"Lastname":user[2],"Username":user[3],"Email":user[4],"Access_level":user[5]}
            response = jsonify(response)
            response.headers.add("Access-Control-Allow-Origin", "*")
            return response

    abort(404, message="User not found")

def Validate_token(token):
    try:
        idinfo=id_token.verify_oauth2_token(token,greq.Request(),ouath_id)
        print("\nToken Valid. User:{}\nUser Data:\n{}\n"
        .format(idinfo['given_name'],idinfo))
        return idinfo
    except ValueError as err:
        print(f"Token Validation failed: {err}")
    return False    
    

@app.route("/")
def front_page():
    return render_template("front_page.html")

@app.route("/livesearch",methods=["POST","GET"])
def livesearch():
    searchbox = request.form.get("text")#getting the request from the value

    query="Select Name, Price, Image, Product_id FROM Products WHERE Name LIKE \"%{}%\"".format(searchbox)
    mycursor = db.cursor()
    mycursor.execute(query)
    result = mycursor.fetchall()
    mycursor.close()
    response = {}
    for x in result:
        response[x[3]] = {"Name":x[0], "Price":x[1], "Image":x[2], "Product_id":x[3]}
    return jsonify(response)

@app.route("/<int:Product_id>/")
def itemPage(Product_id):
    return render_template("item.html")




class UserGetAll(Resource):
    def get(self):
        mycursor = db.cursor()
        mycursor.execute("SELECT User_id, Firstname, Lastname, Username, Password, Email FROM Customers")
        response = []
        result = mycursor.fetchall()
        mycursor.close()
        for user  in result:       
            response.append({"user_id": user[0], "Firstname":user[1],"Lastname":user[2],"Username":user[3],"Email":user[4]})
        response = jsonify(response)
        response.headers.add("Access-Control-Allow-Origin", "*")
        return response

class Login_with_username_and_password(Resource):
    def get(self, Username, Password):
        global counter
        mycursor = db.cursor()
        try:
            mycursor.execute("SELECT User_id, Firstname, Lastname, Username, Email, Access_level FROM Customers WHERE Username = \"{}\" AND Password = \"{}\"".format(Username, Password))
        except:
            abort(404, message="User not found")

        result = mycursor.fetchall()
        counter['loggedin']+=1
        mycursor.close()
        for user  in result:       
            response = {"user_id": user[0],"Firstname":user[1],"Lastname":user[2],"Username":user[3],"Email":user[4],"Access_level":user[5]}
            response = jsonify(response)
            response.headers.add("Access-Control-Allow-Origin", "*")
            return response

        abort(404, message="User not found")
class Login_with_username_and_email(Resource):
    def get(self, Username, Email):
        global counter
        mycursor = db.cursor()
        try:
            mycursor.execute("SELECT User_id, Firstname, Lastname, Username, Email, Access_level FROM Customers WHERE Username = \"{}\" AND Email = \"{}\"".format(Username, Email))
        except:
            abort(404, message="User not found")
        result = mycursor.fetchall()
        counter['loggedin']+=1
        mycursor.close()
        for user  in result:       
            response = {"user_id": user[0],"Firstname":user[1],"Lastname":user[2],"Username":user[3],"Email":user[4],"Access_level":user[5]}
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
        mycursor = db.cursor()

        try:
            mycursor.execute("INSERT INTO Customers (Firstname, Lastname, Username, Password, Email) VALUES (%s, %s, %s, %s, %s)",(data['Firstname'], data['Lastname'] ,data['Username'], data['Password'], data['Email']))
            db.commit()
        except:
           abort(401, message = "Username or password is already taken.")
        mycursor.close()


api.add_resource(Login_with_username_and_password, "/user/<Username>/<Password>/")
api.add_resource(Login_with_username_and_email, "/userM/<Username>/<Email>/")
api.add_resource(UserPost, "/user/")
api.add_resource(UserGetAll, "/users/")

class item(Resource):
    def get(self, Product_id): # get an item from the db
        global counter
        mycursor = db.cursor(buffered=True)
        try:
            mycursor.execute("SELECT * FROM Products WHERE Product_id={}".format(int(Product_id)))
        except:
            abort(404, message="product not found")
        result = mycursor.fetchall()
        mycursor.close()
        counter['getitem']+=1
            
        #response =  {}
        for product in result:
            
            item = {
                "Product_id":product[0],
                "Category_id":product[1],
                "Name":product[2],
                "Price":product[3],
                "Image":product[4],
                "Description":product[5],
                "Specification":product[6]
            }
            #response[product[0]] = item

            response = jsonify(item)
            response.headers.add("Access-Control-Allow-Origin", "*")
            return response

class itemPost(Resource):
    def get(self):#getting multiple items
        parser = reqparse.RequestParser()
        parser.add_argument("Items")
        data = parser.parse_args()
        items = data['Items'].split(",")
        response = {}
        mycursor = None
        try:
            mycursor = db.cursor()
        except:
            if db.is_connected():
                itemPost.get(self)
            else:
                print("lost connection to database")
        for Product_id in items:
            try:
                mycursor.execute("SELECT * FROM Products WHERE Product_id={}".format(int(Product_id)))
            except:
                abort(404, message="product not found")
            result = mycursor.fetchall()
            
            
            for product in result:
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
        mycursor.close()
        response = jsonify(response)
        response.headers.add("Access-Control-Allow-Origin", "*")       
        return response

    def post(self): # add an item to the db (admin)
        parser = reqparse.RequestParser()

        parser.add_argument("Name")
        parser.add_argument("Price")
        parser.add_argument("Category_id")
        parser.add_argument("Description")
        parser.add_argument("Specification")

        data = parser.parse_args()
        mycursor = db.cursor()
        try:   
            image = request.files['pictures']
            if image.filename:
                image.save(os.path.join(os.getcwd() + "/static/Pictures/", image.filename))

                mycursor.execute("INSERT INTO Products (Name, Price, Image, Category_id, Description, Specification) VALUES (%s, %s, %s, %s, %s, %s)",(data['Name'], int(data['Price']), image.filename, int(data['Category_id']), data['Description'], data['Specification']))
                db.commit()
            else:
                mycursor.execute("INSERT INTO Products (Name, Price, Image, Category_id, Description, Specification) VALUES (%s, %s, %s, %s, %s, %s)",(data['Name'], int(data['Price']), "placeholder.PNG", int(data['Category_id']), data['Description'], data['Specification']))
                db.commit()

        except:
            abort(401, message = "Product is already registered.")
        mycursor.close()

        url = request.url.split("?")[0].replace("/item/", "/admin/")
        
        return redirect(url)
        

api.add_resource(item, "/item/<int:Product_id>/")
api.add_resource(itemPost, "/item/")
    
class Categories(Resource):
    def get(self): #getting all categories
        mycursor = db.cursor()
        try:
            mycursor.execute("SELECT * FROM Categories")
        except:
            abort(404, message="Unable to fetch Categories")
        response = {}
        result = mycursor.fetchall()
        mycursor.close()
        for value in result:
            response[value[0]] = {"Category_id":value[0], "Category":value[1]}
        
        response = jsonify(response)
        response.headers.add("Access-Control-Allow-Origin", "*")
        return response
api.add_resource(Categories, "/Categories/")

class Category(Resource):
    def get(self, Category_id): #getting a category
        mycursor = db.cursor()
        try:
            mycursor.execute("SELECT * FROM Categories WHERE Category_id = {}".format(Category_id))
        except:
            abort(404, message="invalid category was given")
        response = {}
        result = mycursor.fetchall()
        mycursor.close()
        for value in result:
            response[value[0]] = {"Category_id":value[0], "Category":value[1]}
            
        response = jsonify(response)
        response.headers.add("Access-Control-Allow-Origin", "*")
        return response
        
api.add_resource(Category, "/Category/<int:Category_id>/")

class getAllInCategory(Resource):
    def get(self, Category_id):
        mycursor = db.cursor()
        mycursor.execute("SELECT p.Product_id, Categories.Name, p.Name, p.Price, p.Image, p.Description, p.Specification FROM Products as p, Categories WHERE p.Category_id={} AND p.Category_id=Categories.Category_id".format(int(Category_id)))
        
        response = {}
        result = mycursor.fetchall()
        mycursor.close()
        for product in result:

            x = {
                "Product_id":product[0],
                "Category_Name":product[1],
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
        global counter
        parser = reqparse.RequestParser()
        parser.add_argument("User_id")
        parser.add_argument("Product_id")
        parser.add_argument("Amount")
        
        data = parser.parse_args()
        mycursor = db.cursor()
        try:#checking if user has the product in their cart
            mycursor.execute("SELECT Amount FROM Carts WHERE User_id=%s AND Product_id=%s AND Ordered=%s",(int(data['User_id']),int(data['Product_id']), "No"))
        except:
            abort(404, message="Unable to check your cart")
        result = mycursor.fetchall()
        
        counter['addtocart']+=int(data['Amount'])
        if(len(result) < 1):
            try:
                mycursor.execute("INSERT INTO Carts (User_id, Product_id, Amount, Ordered) VALUES (%s,%s,%s,%s)", (int(data['User_id']), int(data['Product_id']), int(data['Amount']), "No"))
                db.commit()
            except:
                abort(405, message="Unable to add product to cart")
        else:   
            amount = result[0][0] + int(data['Amount'])
            mycursor.execute("UPDATE Carts SET Amount={} WHERE User_id={} AND Product_id={}".format(amount, int(data['User_id']), int(data['Product_id'])))
            db.commit()
        mycursor.close()
        return 200
    def get(self): #get all in a cart
        parser = reqparse.RequestParser()
        parser.add_argument("User_id")
        data = parser.parse_args()
        mycursor = db.cursor(buffered=True)
        result = None
        try:
            mycursor.execute("SELECT Carts.Cart_id, P.Product_id, P.Category_id, P.Name, P.Price, P.Image, P.Description, Carts.Amount FROM Products as P LEFT JOIN Carts ON P.Product_id = Carts.Product_id WHERE User_id={} AND Carts.Ordered=\"No\"".format(data['User_id']))
            result = mycursor.fetchall()
        except  mysql.connector.errors.DatabaseError:
            if db.is_connected:
                Cart.get(self)
        response = {}
        
        mycursor.close()
        for product in result:

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
        mycursor = db.cursor()
        try:
            mycursor.execute("DELETE FROM Carts WHERE User_id={} AND Cart_id={}".format(int(data['User_id']), int(data['Cart_id'])))
            db.commit()
        except:
            abort(404, message="User og cart does not exist")
        mycursor.close()
        return 200

    def put(self):
        parser = reqparse.RequestParser()
        parser.add_argument("User_id")
        parser.add_argument("Cart_id")
        parser.add_argument("Amount")
        data = parser.parse_args()
        mycursor = db.cursor()
        try:
            mycursor.execute("UPDATE Carts SET Amount={} WHERE User_id={} AND Cart_id={}".format(int(data['Amount']), int(data['User_id']), int(data['Cart_id'])))
            db.commit()
        except:
            abort(404, message="Unable to update amount products selected user or cart may not exist")
        mycursor.close()
        return 200
api.add_resource(Cart, "/Cart/")
class Order(Resource):
    def post(self):
        global counter
        parser = reqparse.RequestParser()
        parser.add_argument("User_id")
        data = parser.parse_args()

        mycursor = db.cursor()

        mycursor.execute("SELECT Product_id, Amount FROM Carts WHERE User_id={} AND Ordered=\"No\"".format(int(data['User_id'])))
        results = mycursor.fetchall()
        

        for Product_id, Amount in results:
            counter['orderitem']+=Amount
            mycursor.execute("INSERT INTO Orders (User_id, Product_id, Amount) VALUES ({},{},{})".format(int(data['User_id']), int(Product_id), int(Amount)))

        mycursor.execute("DELETE FROM Carts WHERE User_id={}".format(int(data['User_id'])))
        db.commit()
        mycursor.close()
        return 200




        


api.add_resource(Order, "/Order/")
if __name__ == "__main__":
    #app.run(debug=True) #comment out for docker
    #https://blog.miguelgrinberg.com/post/running-your-flask-application-over-https ssl_context for self-certificate
    app.run(host="0.0.0.0", debug=True, ssl_context=("/var/site/TLSKeys/cert.pem", "/var/site/TLSKeys/key.pem")) #leave in for docker
    db.close()

    