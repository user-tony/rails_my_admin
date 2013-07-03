option_select = (value) ->
	'<option vlaue="'+value+'" >'+value+'</option>'

options_select_data = (x) ->
	int 			= ['=', '≠', '>', '<', '≤', '≥', 'IN', 'IS NULL' ]
	varchar 	= ['=', '≠', 'LIKE', 'IS NULL']
	text    	= ['=', '≠', 'LIKE', 'IS NULL']
	datetime  = ['=', '≠', '≥', '≤', 'IS NULL']
	tinyint   = ['=', '≠', 'IS NULL']
	switch x
	  when "int" then option_select key for key in int
	  when "varchar" then option_select key for key in varchar
	  when "text" then option_select key for key in text
	  when "datetime" then option_select key for key in datetime
	  when "tinyint" then option_select key for key in tinyint

remove_tr = (id) ->
	$('.tr_'+id).fadeToggle("slow", "linear");
	$('#edit_tables .edit_checkbox:checked').attr('checked', false)
	checked_status()


checked_status = -> 
	$('#btn_delete').attr('disabled', !$('#edit_tables .edit_checkbox:checked').length > 0)
	$('#select_num').html $('#edit_tables .edit_checkbox:checked').length || 0
	

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
	$('.row-fluid .datetime').on 'click', -> $(this).dynDateTime()

	height = Math.floor($('#main .content').height()/40)+18
	if ($('.main-menu-span .well ul li').size() > height)
		$('.main-menu-span .well ul li:gt('+height+')').slideToggle();
		$('.main-menu-span .well ul li:eq('+height+')').after('<li> <a href="#" id="more">查看更多....</a></li>');
		$('.main-menu-span .well ul li a#more').on 'click', ->
			$('.main-menu-span .well ul li:gt('+height+')').slideToggle()
			false
		false

	checked_status()

	$('#field').on 'click', 'option',  -> $('#calc').html(options_select_data($(this).attr('column_type')))
	$('#edit_tables').on 'click', '.edit_checkbox', ->
		$(this).parents('tr').toggleClass('active')
		checked_status()

	$('#edit_tools').on 'click', '.deselect', ->
		$('#edit_tables .edit_checkbox:checked').attr('checked', false)
		checked_status()
		for input_check in $('#edit_tables .edit_checkbox')
			do (input_check) ->
				$(input_check).parents('tr').removeClass("active")
		false

	for input_check in $('#edit_tables .edit_checkbox:checked')
		do (input_check) ->
			$(input_check).parents('tr').addClass("active")

	$('#btn_delete').on 'click', ->
		return false if $(this).attr('disabled')
		if(window.confirm("确定要删除么?"))
			$.ajax
				url: $('#details_form').attr("action"), data: $('#details_form').serialize(), type: 'delete', dataType: 'json',
				success: (data) -> remove_tr id for id in data
		false

	$('#field option:first').click()

	false