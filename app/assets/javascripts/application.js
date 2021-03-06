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
//= require jquery.ui.all
//= require jquery_ujs
//= require active_scaffold
//= require_tree .


function areInputsFilled(selector) {
	var filled = false;
	$(selector).each(function() {
	   var element = $(this);
	   if (element.val() != "") {
	       filled = true;
	   }
	});
	return filled;
}

function confirmOnPageExit(){
	if (areInputsFilled('.as_form.update input[type=text], .as_form.create input[type=text]')) {
		return 'Existem campos preenchidos! Você pode perder suas alterações!';
	}
}

$(document).ready(function(){
	window.onbeforeunload = confirmOnPageExit;
});