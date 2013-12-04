function show_category_list_env_nr4() {
//function show_category_list_list_env_nr4() {
	
	var select_genre = $("#env_nr4_genre_id");
	
	var selected_genre_id = select_genre.val();
	
//	alert("selected_genre_id ==> id=" + selected_genre_id);
	
//	alert("Selected genre => " + selected_genre_id);
	
	// Chagne the div background to yellow while ajaxing
	//REF .css() http://stackoverflow.com/questions/4283141/jquery-change-background-color answered Nov 26 '10 at 7:12
	$("#category_list").css("background-color", "yellow");
	
	$.ajax({
		
//	    url: "/env_nr4s/show_category_list?selected_genre=" + selected_genre_id,
	    url: "/nr4/env_nr4s/show_category_list?selected_genre=" + selected_genre_id,
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

function backup_db() {
	
	$("div#backup_result").css("background-color", "yellow");
	
	$("div#backup_result").text("Processing...");
	
//	$("div#backup_result").css("disabled", "true");	// Not working
//	$("div#backup_result").attr("disabled", 'true');
	
	//REF http://d.hatena.ne.jp/ogakky/20110711/1310349297
	$("input#backup_button").attr("disabled", true);
	
//	var data = {"data[Keyword][name]": "android"};	//=> Works
	var data = {"data[Keyword][name]": "書き込み可能",
				"data[Keyword][category_id]": 3
			};
//	var data = {"data[Keyword][created]": "333333"};
	
//	alert("Starting backup...");
	$.ajax({
		
		
//	    url: "/env_nr4s/show_category_list?selected_genre=" + selected_genre_id,
//	    url: "/nr4/env_nr4s/backup_db",
//		type: "GET",
		
//		type: "POST",
//	    url: "http://benfranklin.chips.jp/rails_apps/nr4/cakephp-2.3.10/keywords/add?data[Keyword][name]=android",
//	    url: "http://benfranklin.chips.jp/rails_apps/nr4/cakephp-2.3.10/keywords/add",
	    
	    
	    
		type: "GET",
	    
//	    url: "http://benfranklin.chips.jp/rails_apps/nr4/cakephp-2.3.10/keywords/add?data[Keyword][name]=android",
	    url: "/nr4/env_nr4s/backup_db",
	    
	    data: data,
	    timeout: 10000
	    
	}).done(function(data, status, xhr) {
		
		$("div#backup_result").css("background-color", "white");
//		$("div#backup_result").html(data);
//		$("div#backup_result").text("Posted to remote: " + xhr.status);
//		$("div#backup_result").text("Backup db => Done : " + xhr.status);
		$("div#backup_result").text(data + xhr.status);
//		$("div#backup_result").text(data);
		
		$("input#backup_button").attr("disabled", false);
		
//		$("#category_list").html(data);
		
	    
	}).fail(function(xhr, status, error) {
		
		$("div#backup_result").css("background-color", "red");
		
//	    $("div#backup_result").append("xhr.status = " + xhr.status + "<br>");          // 例: 404
	    $("div#backup_result").text("xhr.status = " + xhr.status + "<br>");          // 例: 404
	    
	    $("input#backup_button").attr("disabled", false);
	    
	});

	
}
