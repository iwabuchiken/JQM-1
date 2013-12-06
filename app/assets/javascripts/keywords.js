function show_genre_list() {
	
	var list = $("#genre_list").html();
//	var message = "";
	
	if (list == "") {
		
		$.ajax({
			
		    url: "/nr4/keywords/show_genre_list",
		    type: "GET",
		    timeout: 10000
		    
		}).done(function(data, status, xhr) {
			
	//	    $("#js").html(data);
	//	    $("#js").append(data);
		    $("#genre_list").prepend(data);
	//	    $("#js").append("<br/>");
		    
		    
		}).fail(function(xhr, status, error) {
			
		    $("#genre_list").append("xhr.status = " + xhr.status + "<br>");          // 例: 404
		    
		});
	}
//	
//	//REF values http://d.hatena.ne.jp/unageanu/20070705/1183627496
//	if (list == "") {
//		message = "blank";
//	} else if (list == null) {
//		message = "null";
//	} else if (list == undefined) {
//		message = "undefined";
//	} else {
//		message = "Something else";
//	}
//	
//	alert(message);
	
//	alert("Show genre list");
	

	
}

function show_category_list() {
	
	var select_genre = $("#keyword_genre_id");
	
	var selected_genre_id = select_genre.val();
	
//	alert("Selected genre => " + selected_genre_id);
	
	// Chagne the div background to yellow while ajaxing
	//REF .css() http://stackoverflow.com/questions/4283141/jquery-change-background-color answered Nov 26 '10 at 7:12
	$("#category_list").css("background-color", "yellow");
	
	$.ajax({
		
	    url: "/nr4/keywords/show_category_list?selected_genre=" + selected_genre_id,
	    type: "GET",
	    timeout: 10000
	    
	}).done(function(data, status, xhr) {
		
		$("#category_list").css("background-color", "white");
		
//	    $("#js").html(data);
//	    $("#js").append(data);
		$("#category_list").html(data);
//	    $("#js").append("<br/>");
		
		// Get the background color back to white
	    
	    
	}).fail(function(xhr, status, error) {
		
	    $("#genre_list").append("xhr.status = " + xhr.status + "<br>");          // 例: 404
	    
	});
	
//	$("#category_list").html("Selected genre => " + selected_genre_id);
	
}//function show_category_list() {


//REF http://web.mt-systems.jp/tech/cakephp/jqueryajax2
//REF http://api.jquery.com/val/
//REF http://semooh.jp/jquery/api/events/change/fn/src-1/
//$(document).ready(function() {
//	  $("#keyword_genre_id").change(function() {
//		  
////		  alert("Changing...");
//		  
////		  var select = $("#keyword_genre_id");
////		  //REF http://stackoverflow.com/questions/1085801/how-to-get-the-selected-value-of-dropdownlist-using-javascript
////		  var selected_genre_id = select.options[select.selectedIndex].value;
//		  
//		  //REF val() http://stackoverflow.com/questions/2780566/to-get-selected-value-of-a-dropdown-select-element-in-jquery answered May 6 '10 at 11:11
//		  var selected_genre_id = $('#keyword_genre_id').val();
//		  
//		  $("#category_list").css("background-color", "yellow");
//		  
////		  show_category_list();
//		  $.ajax({
//				
//			    url: "/nr4/keywords/show_category_list?selected_genre=" + selected_genre_id,
//			    type: "GET",
//			    timeout: 10000
//			    
//			}).done(function(data, status, xhr) {
//				
//				$("#category_list").css("background-color", "white");
//				
////			    $("#js").html(data);
////			    $("#js").append(data);
//				$("#category_list").html(data);
////			    $("#js").append("<br/>");
//				
//				// Get the background color back to white
//			    
//			    
//			}).fail(function(xhr, status, error) {
//				
//			    $("#genre_list").append("xhr.status = " + xhr.status + "<br>");          // 例: 404
//			    
//			});
//		  
////		  alert("Selected => " + selected_genre_id);
//		  
////		  alert("Changed");
////	    $.get(
////	    		"/nr4/keywords/show_category_list"
////	    		+ "?selected_genre="
////	    		+ selected_genre_id,
////	    		function(data) {
////	    			$("#category_list").html(data);}
////	    );
////	  //});
////	  //REF .change() http://semooh.jp/jquery/api/events/change/fn/
////	  });
//		}).change();
//
//});
