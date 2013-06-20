$(document).ready ->
	if document.getElementById("search-textarea")
		editor = CodeMirror.fromTextArea(document.getElementById("search-textarea"), {
				mode: "text/x-sql",
				tabMode: "indent",
				lineNumbers: true,
				matchBrackets: true,
				indentUnit: 2
		  });
		editor.setOption("theme", 'twillght');

	$('span.edit_datepicker').on 'click', 'textarea', -> $(this).dynDateTime()
	# if ($('.main-menu-span .well ul li').size() > 50)
	# 	$('.main-menu-span .well ul li:gt(25)').slideToggle();
	# 	$('.main-menu-span .well ul li:eq(25)').after('<li> <a href="#" id="more">查看更多....</a></li>');
	# 	$('.main-menu-span .well ul li a#more').on 'click', ->
	# 		$('.main-menu-span .well ul li:gt(25)').slideToggle()
	# 	false
