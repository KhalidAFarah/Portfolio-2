function onSignIn(googleUser){
    var profile = googleUser.getBasicProfile();
   id_token= googleUser.getAuthResponse().id_token;
   logged_in=profile;
   remove_users();
   render_users(users);

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