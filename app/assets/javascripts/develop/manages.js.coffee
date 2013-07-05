option_select = (value) ->
	'<option vlaue="'+value+'" >'+value+'</option>'

remove_tr = (id) ->
	$('.tr_'+id).fadeToggle("slow", "linear");
	$('#edit_tables .edit_checkbox:checked').attr('checked', false)
	checked_status()


checked_status = -> 
	$('#btn_delete').attr('disabled', !$('#edit_tables .edit_checkbox:checked').length > 0)
	$('#select_num').html $('#edit_tables .edit_checkbox:checked').length || 0
	
hidden_input_select_with_name = ->
	$('.check_edit[style!=""] .span3 input, .check_edit[style!=""] .span3 select').attr('name', '')

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

		

	$('#edit_tables').on 'click', '.edit_checkbox', ->
		$(this).parents('tr').toggleClass('active')
		checked_status()

	$('#edit_tools').on 'click', '.deselect', ->
		$('#edit_tables .edit_checkbox:checked').attr('checked', false)
		checked_status()
		for input_check in $('#edit_tables .edit_checkbox')
			do (input_check) -> $(input_check).parents('tr').removeClass("active")
		false

	$('#btn_delete').on 'click', ->
		return false if $(this).attr('disabled')
		if(window.confirm("确定要删除么?"))
			$.ajax
				url: $('#details_form').attr("action"), data: $('#details_form').serialize(), type: 'delete', dataType: 'json',
				success: (data) -> remove_tr id for id in data
		false

	$('div.check_edit').on 'click', '.check_box_edit', ->
		parent = $(this).parents('div.check_edit')
		$('.span3', parent).toggle()
		$('input,select', parent).each -> $(this).attr('name',  if $('.span3', parent).is(":hidden") then  "" else $(this).attr('data-field'))


	$('#select_field').on 'click', 'option', ->
		$('div.' + $(this).val()).slideToggle()
		$('#calc_'+ $(this).val()).attr('name', $('#calc_'+ $(this).val()).attr('data-field'))
		$('#field_'+ $(this).val()).attr('name', $('#field_'+ $(this).val()).attr('data-field'))
		$(this).attr('disabled', 'disabled')


	$('.span8 .clear').on 'click', ->
		$('.check_edit').hide()
		$('#select_field option').each -> $(this).attr('disabled', false)
		hidden_input_select_with_name()


	for input_check in $('#edit_tables .edit_checkbox:checked')
		do (input_check) -> $(input_check).parents('tr').addClass("active")


	# 检查选择状态
	checked_status()
	# 
	hidden_input_select_with_name()


	# 已经显示的条件 在下拉框里不可点击
	$('#select_field option').each -> $(this).attr('disabled', 'disabled') if $('#current_condition').val().split(',').indexOf($(this).val()) >= 0
		
	# 刷新后没有选中的复选框 隐藏后台的查询条件框
	$('.check_edit[style=""] .check_box_edit').each -> $('.span3', $(this).parents('div.check_edit')).hide() if !$(this).is(":checked")
		
	false