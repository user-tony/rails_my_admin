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

	if ($('.main-menu-span .well ul li').size() > 50)
		$('.main-menu-span .well ul li:gt(25)').slideToggle();
		$('.main-menu-span .well ul li:eq(25)').after('<li> <a href="#" id="more">查看更多....</a></li>');
		$('.main-menu-span .well ul li a#more').on 'click', ->
			$('.main-menu-span .well ul li:gt(25)').slideToggle()
		false




	$('span.edit_datepicker').on 'click', 'textarea', -> $(this).dynDateTime()


	# $('#edit_tables')
	# 	.on 'mouseenter', 'td', ->
	# 		$(this).prepend('<a href="#" id="edit_td">[编辑]</a>')
	# 	.on 'mouseleave', 'td', ->
	# 		$('#edit_td',$(this)).remove()
	# 	.on 'click','#edit_td', ->
	# 		td = $(this)
	# 		td.html('<input type="text" value="'+td.attr('title')+'" id="in_tr"> </input>')
		# td.html('<input type="text" value="'+td.attr('title')+'" id="in_tr"> </input>')
		# $('#in_tr').onfocus()
		# 	.focus ->
		# 		alert('1')
		# 	.blur ->
		# 		td.html(td.attr('title'))
