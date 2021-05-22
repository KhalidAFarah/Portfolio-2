//checking if the user is logged inn
function loggedin(){
    var user = JSON.parse(window.localStorage.getItem("user"));
    if(user == null){
        document.getElementsByClassName("sendtotext")[0].innerHTML="Login";
    }else{
        document.getElementsByClassName("sendtotext")[0].innerHTML="Log out";
    }
}loggedin();
$(".loginbtn").on("click",function(){
    var user = JSON.parse(window.localStorage.getItem("user"));
    if(user == null){
        window.location = "https://localhost:5000/Login/";
    }else{
        if (user.Accsess_level<3){
            window.localStorage.removeItem("user");
            window.location = "https://localhost:5000/";
        }
       else{
        var auth2=gapi.auth2.getAuthInstance();
        auth2.signOut().then(function(){
            window.localStorage.removeItem("user");
            window.location = "https://localhost:5000/";
        })
       }
    }
})
//for accessories
var shown = false;
$(".accessories-toggle").on("click", function(){
    
    if(shown == false){
        $(".accessories-menu").show();
        shown = true;
    }else{
        $(".accessories-menu").hide()
        shown = false;
    }
    
});
var accessories = document.getElementsByClassName("accessories-menu")[0];
$(".accessories-toggle").on("focusout", function(){
        $(document).ready(function(){
            if(!accessories.contains(document.activeElement)){
                $(".accessories-menu").hide();
            }
        })
});



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
                        //console.log(value)
                        list.setAttribute("style","display:block;")
                        if(value.Image==null || value.Image==""){
                            value[2]="placeholder.PNG"
                        }
                    var img="<div class=\"col-3\"><img src=\"../static/Pictures/"+value.Image+"\" width=80px length=80px></div>";
                    var name = "<div class=\"col-7\"><p>"+value.Name+"</p></div>";
                    var price = "<div class=\"col-2\"><p>"+value.Price+",-</p></div>";
                    data += "<a class=\"listeditem\" href=\"https://localhost:5000/"+value.Product_id+"\"><li class=\"row\">"+img+" "+name+" "+price+"</li>"; 
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

var user = JSON.parse(localStorage.getItem("user"));
var pressed = false;
var data = null;
var cartdata = document.getElementsByClassName("cartdata")[0];
var items = 0;

function updatecartnumber(items){
    var cartnumberelement = document.getElementsByClassName("cartnumberelement")[0];
    var cartnumber = document.getElementsByClassName("cartnumber")[0];
    
    if(items == 0){
        cartnumber.setAttribute("style", "display: none;")
    }else if(items > 0){
        cartnumber.setAttribute("style", "display: block;")
        
        cartnumberelement.innerHTML = items;
        console.log(items)
    }

}
function getcart(){
    var user = JSON.parse(localStorage.getItem("user"))
    
        
    if(user==null){
        window.location="https://localhost:5000/Login/"
    }

    function updatecartdata(value){
        data = value;
        var amount = 0;
        $.each(value,function(front_page, val){
            amount+=val.Amount;
        })
        if(amount != items){
            if(amount > 0){
                $("cartnumber").show();
            }else{
                $("cartnumber").hide();
            }
            items = amount;
            updatecartnumber(items);
        }
    }
    $.ajax({
        type: "GET",
        url:"https://localhost:5000/Cart/?User_id="+user.user_id,
        async:false,
        success: updatecartdata
    });
}
function getAmount(){
    return items;
}

if(user != null){
    getcart();
    setInterval(getcart, 10000)
    $(".cartbtn").on("click", displaycart)

    
    $(".cartbtn").on("focusout", function(){

        $(document).ready(function(){
            if(!cartdata.contains(document.activeElement)){
                pressed = false;
                $(".cartdata").hide();
                $(".cartdata").empty();
            }
        })
        
    });

}else{
    $(".cartbtn").on("click", function(){
        window.location = "https://localhost:5000/Login/"
    })
}
function displaycart(){

    var keys = Object.keys(data);
    if(pressed==false){
        pressed = true;
        var times = 0;
        $.each(data, function(front_page, value){
            if(times < 3){
                var divRow = document.createElement("div");
                divRow.setAttribute("class", "cartdatarow row");

                var p = document.createElement("a");
                p.setAttribute("class", "cartdatarowlink")
                p.setAttribute("href", "https://localhost:5000/"+value.Product_id)

                var div = document.createElement("div")
                div.setAttribute("class", "col1 col-3");
                
                var img = document.createElement("img");
                img.setAttribute("class", "cartdatarowimg");
                img.setAttribute("src", "https://localhost:5000/img/"+value.Image);
                img.setAttribute("style", "width:100%;")
                div.appendChild(img);
                divRow.appendChild(div);

                var div = document.createElement("div")
                div.setAttribute("class", "col2 col-7");

                

                var a = document.createElement("p");
                a.innerHTML = value.Name;
                a.setAttribute("class", "cartdatarowtext cartdatarowitemname");
                //a.setAttribute("style", " font-size: 18px;padding: 0%;")
                //a.setAttribute("href", "http://localhost:5000/"+value.Product_id)
                div.appendChild(a);
                divRow.appendChild(div);
                

                var div = document.createElement("div")
                div.setAttribute("class", "col3 col-2");
                
                a = document.createElement("p");
                a.innerHTML = value.Price + ",-";
                a.setAttribute("class", "cartdatarowtext");
                a.setAttribute("style", " font-size: 13px;padding: 0%;")
                //a.setAttribute("href", "http://localhost:5000/"+value.Product_id+"/")
                div.appendChild(a);
                divRow.appendChild(div)
                p.appendChild(divRow);


                cartdata.appendChild(p)
                
            }
            times++;
            
        });
        if(times >= 3){
            divRow = document.createElement("div");
            divRow.setAttribute("class", "cartdatarow row border-bottom-1");

            var p = document.createElement("p");
            p.innerHTML = "...";
            p.setAttribute("style", "position:relative;padding:0%;left:0%;top:0%;margin:0%;")
            p.setAttribute("align", "center")
            divRow.appendChild(p);
            cartdata.appendChild(divRow);

        }
        var divRow = document.createElement("div");
        divRow.setAttribute("class", "cartdatarow row");
        var btn = document.createElement("a");
        btn.innerHTML = "Go to Cart"
        btn.setAttribute("style", "padding: 2%; color: dodgerblue")
        btn.setAttribute("href", "https://localhost:5000/cart/")
        divRow.appendChild(btn);
        cartdata.appendChild(divRow);
        cartdata.setAttribute("style", "max-height: 100%;")
        
    }else{
        pressed = false;
        $(".cartdata").hide();
        $(".cartdata").empty();
    }
}

