$(document).ready(function(){
  $("#reminder_signup").on("click", function(event){
    event.preventDefault();
    $("#reminder-settings-form").show();
    $("#reminder_signup").hide();
  });
});
