function show_genre_list() {
	
//	alert("Show genre list");
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