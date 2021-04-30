from flask import Flask,render_template,request,jsonify #to import other files
from flask_mysqldb import mysql
app = Flask(__name__)
mysql = mysql(app)

app.config["MYSQL_HOST"]= ""

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


if __name__ == "__main__":
    app.run(debug=True)
