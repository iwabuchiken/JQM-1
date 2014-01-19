//# Place all the behaviors and hooks related to the matching controller here.
//# All this logic will automatically be available in application.js.
//# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


function show_items(id_num) {
	
	alert("SHOW!!! => " + id_num);
	
//	$("item_hist_id_" + id_num).css("inline", true);
	
//	$("#show_button_generic").attr("disabled", true);
}

function hide_items(id_num) {
	
	alert("HIDE!!! => " + id_num);
	
	$("#item_hist_id_" + id_num.toString()).css("display", "none");
//	$("#item_hist_id_" + id_num.toString()).css("display", "inline");
//	$("#item_hist_id_" + id_num.toString()).html("ABC");
//	$("#item_hist_id_" + id_num).html("ABC");
//	$("item_hist_id_" + id_num).html("ABC");
//	$("item_hist_id_" + id_num).css("inline", true);
	
}

function toggle_visibility(id) {
    var e = document.getElementById("item_hist_id_" + id);
    
    alert("Toggling => " + id);
    
    if(e.style.display == 'block')
       e.style.display = 'none';
    else
       e.style.display = 'block';
}
