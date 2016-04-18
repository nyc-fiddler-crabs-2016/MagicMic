$(document).ready(function(){
  $(".unsave-link").on("click", function(event){
    var url = this.href
    var request = $.ajax({
    	url: url,
    	type: 'delete'
    }).done(function(response){
      $(".unsave-link").parent.fadeout
    })
    return false

    // This jquery preventdefault doesn't work on the delete link. Probably because the default of a link is a get and there is a lot of rails magic going on behind the scenes. I saw a few attempts on SOF. One requires a bunch of steps to override all that rails magic. 
    // The other would require reformatting the site a little so that each link is a partial that gets rendered which contains all the code from lines 15-16 of the user show. then when any broadcast is removed the html you just call fadeOut() on the containing div. Actually I think both of these steps might be required.HMMMM.
 
    })
});