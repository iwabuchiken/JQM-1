/*
 * #show_button
 * #show_button_generic
 * 
 * #show_log
 * 
 * #hide_button
 * #hide_button_generic
 * 
 * #item_refactor_table_word_lists
 * 
 * .log_navigation
 * 
 */

// REF http://stackoverflow.com/questions/2672355/calling-jquery-method-from-onclick-attribute-in-html answered Apr 20 '10 at 3:40
function showMessage(msg) {
   alert(msg + " => Shown");
   // alert(msg);
};

function show_log(app_name) {
//function show_log(obj, app_name) {
	
	$("#show_button_generic").attr("disabled", true);
	
//	alert("obj => " + obj);
	
//	alert("app name is ... " + app_name);
	
	var show_log_path = ""
	
	if (app_name == "sl") {
		
		show_log_path = "/sl/items/show_log";
//		show_log_path = "/items/show_log";
		
	} else {
		
		show_log_path = "/nr4/genres/show_log";
		
	}//if (app_name == "sl") {
	
	
//	  obj.attr("disabled", true);
//	  $(this).attr("disabled", true);

	  //REF http://www.tohoho-web.com/js/jquery/ajax.htm
	  $.ajax({
		  
//		    url: "/genres/show_log",
		  url: show_log_path,
		  type: "GET",
		  timeout: 10000
		  
	  }).done(function(data, status, xhr) {
		  
		  $("#show_log").html(data);
		  
		  //REF http://stackoverflow.com/questions/3806685/jquery-add-disabled-attribute-to-input answered Sep 27 '10 at 18:32
//		    document.getElementById("show_log").disabled = true;	//=> Not working
		  
		  $("#hide_button_generic").removeAttr("disabled");
		  
		  $(".log_navigation").show();
		  
		  
	  }).fail(function(xhr, status, error) {
		  
		  $("#show_log").append("<br>xhr.status = " + xhr.status + "<br>");          // 例: 404
		  
	  });//$.ajax({

	
	
}

function hide_log() {
	
	  $("#show_log").html("LOG");
	  
	  $("#hide_button_generic").attr("disabled", true);
	  
	  $("#show_button_generic").removeAttr("disabled");
	  
	  $(".log_navigation").hide();

}

$(document).ready(function(){
  
  $("#show_button").click(function(){
	  
	  $(this).attr("disabled", true);
	  
	  //REF http://www.tohoho-web.com/js/jquery/ajax.htm
	  $.ajax({
//		    url: "/genres/show_log",
		    url: "/nr4/genres/show_log",
		    type: "GET",
		    timeout: 10000
		}).done(function(data, status, xhr) {
			
		    $("#show_log").html(data);
		    
//		    $(this).prop("disabled", true);	//=> Not working
		    
//		    $(this).attr("disabled", true);	//=> Not working
		    
		    //REF http://stackoverflow.com/questions/3806685/jquery-add-disabled-attribute-to-input answered Sep 27 '10 at 18:32
//		    document.getElementById("show_log").disabled = true;	//=> Not working
		    
		    $(this).attr("disabled", true);
		    
		    $("#hide_button").removeAttr("disabled");
		    
		    $(".log_navigation").show();
		    
		    
		}).fail(function(xhr, status, error) {
			
		    $("#show_log").append("xhr.status = " + xhr.status + "<br>");          // 例: 404
		    
		});
	  
  });//$("#show_button").click(function(){
  
  $("#show_button_generic").click(function(){
	  
//	  var app_name = $("#app_name").text();
	  var app_name = $("#app_name").attr("value");
	  
//	  show_log(this, app_name);
	  show_log(app_name);
	  
  });//$("#show_button").click(function(){
  
  $("#hide_button").click(function(){

	  $("#show_log").html("LOG");
	  
	  $(this).attr("disabled", true);
	  
	  $("#show_button").removeAttr("disabled");
	  
	  $(".log_navigation").hide();
	  
  });//$("#hide_button").click(function(){
  
  $("#hide_button_generic").click(function(){
	  
	  hide_log();
	  
  });//$("#hide_button").click(function(){
  
  $("#item_refactor_table_word_lists").click(function(){

    // alert($(this).css("value"));
    // alert($(this).attr("value"));

    
  });
  
  // 
  
});