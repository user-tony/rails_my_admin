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
	height = Math.floor($('#content #nav').height()/40)+18
	if ($('.main-menu-span .well ul li').size() > height)
		$('.main-menu-span .well ul li:gt('+height+')').slideToggle();
		$('.main-menu-span .well ul li:eq('+height+')').after('<li> <a href="#" id="more">查看更多....</a></li>');
		$('.main-menu-span .well ul li a#more').on 'click', ->
			$('.main-menu-span .well ul li:gt('+height+')').slideToggle()
			false
		false