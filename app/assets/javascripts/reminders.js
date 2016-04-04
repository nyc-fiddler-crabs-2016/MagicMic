$(document).ready(function(){
  $("#reminder_signup").on("click", function(event){
    event.preventDefault();
    console.log("sup");
    $("#reminder-settings-form").show();
    $("#reminder_signup").hide();
  });
});
