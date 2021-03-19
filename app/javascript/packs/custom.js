window.onload = ()=>{
    document.getElementById("user_username").addEventListener("keyup", validate_username);
} 
validate_username = function validateUserName(username) {
  username = document.getElementById("user_username").value;
  var usernameRegex = /^[a-zA-Z0-9_]+$/;
  if (!username) {
    document.getElementById("user_username").style.backgroundColor = "white";
  }else if(usernameRegex.test(username)){
    document.getElementById("user_username").style.backgroundColor = "yellow";
  } else {
    document.getElementById("user_username").style.backgroundColor = "red";
  }
};