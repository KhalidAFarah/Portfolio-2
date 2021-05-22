function onSignIn(googleUser){
   var profile = googleUser.getBasicProfile();
   id_token= googleUser.getAuthResponse().id_token;
   logged_in=profile;
   remove_users();
   render_users(users);

   $.ajax({
       method:"Post",
       url:"https://localhost:5000/userg/"+id_token+"/",
       success:function(res){
        window.localStorage.setItem("user",JSON.stringify(json));
        if(window.localStorage.getItem("PrevPage") == null){
            window.location = "http://localhost:5000/"}
            else{
                window.location=window.localStorage.getItem("PrevPage");
            }
            
        }
       })

    

}

function signOut(){
    var auth2=gapi.auth2.getAuthInstance();
    auth2.signOut().then(function(){
        console.log('User sign out');
        logged_in=null;
        remove_users();
        load_users();

    });
    id_token=null;
}
