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