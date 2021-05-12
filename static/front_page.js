//for the searchbar
$(document).ready(function(){
    $("#livebox").on("input",function(e){
        $("#list").empty();
        $.ajax({
            method:"post",
            url:"/livesearch",
            data:{text:$("#livebox").val()},
            success:function(res){
                var data = "<ul>";
                $.each(res,function(front_page,value){
                    if($(livebox).val().length>3){
                        list.setAttribute("style","display:block;")
                        if(value[2]==null || value[2]==""){
                     value[2]="placeholder.PNG"
                    }
                    var img="<img src=\"../static/Pictures/"+value[2]+"\" width=80px length=80px>"
                    data += "<li>"+img+" "+value[1]+"kr"+" "+value[0]+"</li>"; 
                    } 
                    else{
                        list.setAttribute("style","display:none;")
                    }
                });
                data += "</ul>";
                $("#list").html(data);
            }
        });
    });
});

//for the shopping cart

var user = JSON.parse(localStorage.getItem("user"))
    //var cartdata = document.getElementsByClassName("cartdata");
   // console.log(cartdata);
    //var pressed = false;
    function showcart(){
        var user = JSON.parse(localStorage.getItem("user"))
        var cartdata = document.getElementsByClassName("cartdata")[0];
        console.log(cartdata);
        var pressed = false;
        function displaycart(data){

            console.log(data);
            var keys = Object.keys(data);
            if(pressed==false){
                var times = 0;
                $.each(data, function(front_page, value){
                    if(times < 3){
                        var divRow = document.createElement("div");
                        divRow.setAttribute("class", "cartdatarow");

                        var div = document.createElement("div")
                        div.setAttribute("class", "col1");
                        
                        var img = document.createElement("img");
                        img.setAttribute("class", "cartdatarowimg");
                        img.setAttribute("src", "../static/Pictures/"+value.Image);
                        div.appendChild(img);
                        divRow.appendChild(div);

                        var div = document.createElement("div")
                        div.setAttribute("class", "col2");

                        var a = document.createElement("a");
                        a.innerHTML = value.Name;
                        a.setAttribute("class", "cartdatarowtext");
                        a.setAttribute("style", "display: inline; width: 75%; font-size: 13px;padding: 0%;")
                        a.setAttribute("href", "http://localhost:5000/"+value.Product_id)
                        div.appendChild(a);
                        divRow.appendChild(div);

                        var div = document.createElement("div")
                        div.setAttribute("class", "col3");
                        
                        a = document.createElement("a");
                        a.innerHTML = value.Price + " Kr";
                        a.setAttribute("class", "cartdatarowtext");
                        a.setAttribute("style", "display: inline; width: 75%; font-size: 13px;padding: 0%;")
                        a.setAttribute("href", "http://localhost:5000/"+value.Product_id+"/")
                        console.log(cartdata);
                        div.appendChild(a);
                        divRow.appendChild(div);


                        cartdata.appendChild(divRow)
                        
                    }
                    times++;
                    
                });
                if(times >= 3){
                    divRow = document.createElement("div");
                    divRow.setAttribute("class", "cartdatarow");

                    var p = document.createElement("p");
                    p.innerHTML = "...";
                    p.setAttribute("style", "position:relative;padding:0%;left:0%;top:0%;margin:0%;")
                    p.setAttribute("align", "center")
                    divRow.appendChild(p);
                    cartdata.appendChild(divRow);

                }
                var divRow = document.createElement("div");
                divRow.setAttribute("class", "cartdatarow");
                var btn = document.createElement("a");
                btn.innerHTML = "Go to Cart"
                btn.setAttribute("style", "padding: 2%; color: dodgerblue")
                btn.setAttribute("href", "http://localhost:5000/cart/")
                divRow.appendChild(btn);
                cartdata.appendChild(divRow);
                cartdata.setAttribute("style", "max-height: 100%;")
                pressed = true;
            }else{
                pressed = false;
                cartdata.setAttribute("style", "max-height: 0%;")
                $(".cartdata").empty().delay(800).fadeIn(400)
            }
        
            
        }
        if(user==null){
            window.location="http://localhost:5000/Login/"
        }
        $.get("http://localhost:5000/Cart/?User_id="+user.user_id,displaycart)

    }