// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_tree .

$(document).ready(function(){
    
  $('#offer_offer_start_date').datepicker();
  $('#offer_offer_end_date').datepicker();
  
  
  //$("#field_country").css("display","none");
  
  
  
  
  if( $('#offer_offer_worldwide').is(':checked')) {
  	
  	 $("#field_country").hide();  	 
  	 $("#offer_country_id").attr("disabled", "disabled");  	 
  	 //$('#new_offer').append('<input type="hidden" name="country_id" value="0" />');
  	// $("#offer_country_id").val("0");

  }
  
  $('#offer_offer_worldwide').click(function() {
    if( $(this).is(':checked')) {       
          $("#field_country").hide();         
		  $("#offer_country_id").attr("disabled", "disabled");  
          
         // $('#new_offer').append('<input type="hidden" name="country_id" value="0" />');
      //    $("#offer_country_id").val("0");
    } else {
       $("#field_country").show();
       $("#offer_country_id").removeAttr("disabled");

    }
}); 
  
  
  $('#new_offer').submit(function() {
  	$("#field_country").attr('selectedIndex', 0);  
  });
  
  
  	
});







/*function popupCenter(url, width, height, name) {
  var left = (screen.width/2)-(width/2);
  var top = (screen.height/2)-(height/2);
  return window.open(url, name, "menubar=no,toolbar=no,status=no,width="+width+",height="+height+",toolbar=no,left="+left+",top="+top);
}
$(document).ready(function(){
	$("a.popup").click(function(e) {
	  popupCenter($(this).attr("href"), $(this).attr("data-width"), $(this).attr("data-height"), "authPopup");
	  e.stopPropagation(); return false;
	});
});*/