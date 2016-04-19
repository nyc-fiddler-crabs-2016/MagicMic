$(document).ready(function(){
  $(".unsave-link").on("click", function(event){
    event.preventDefault();
    var $link = $(event.target);
    var request = $.ajax({
    	url: $link.attr('href'),
    	type: 'delete'
    }).done(function(response){
    	console.log("success");
        console.log(response);
      $link.parent().hide();
    }).fail(function(response){
    	console.log("fail");
    	console.log(response);
    	$link.parent().hide();
    });
  }).bind(this);
});