option_select = (value) ->
	'<option vlaue="'+value+'" >'+value+'</option>'

remove_tr = (id) ->
	$('.tr_'+id).fadeToggle("slow", "linear");
	$('.tablescroll .edit_checkbox:checked').prop('checked', false)
	checked_status()


checked_status = -> 
	if $('.tablescroll .edit_checkbox:checked').length > 0 then $('#btn_del').show() else $('#btn_del').hide()

	
hidden_input_select_with_name = ->
	$('.check_edit[style!=""] .span3 input, .check_edit[style!=""] .span3 select').attr('name', '')

search_input_change = ->
	for li in $('.link_list li')
		do (li) ->
			return $(li).show() if $.trim($('#seaerch-T').val()).length == 0
			if RegExp($('#seaerch-T').val().toLocaleLowerCase()).test($(li).attr('data-field')) then $(li).show() else $(li).hide()

$(document).ready ->
	if document.getElementById("search-textarea")
		editor = CodeMirror.fromTextArea(document.getElementById("search-textarea"), {
				mode: "text/x-sql",
				tabMode: "indent",
				smartIndent: true,
				lineNumbers: true,
				matchBrackets: true,
				indentUnit: 2
		  });

	$('span.edit_datepicker').on 'click', 'textarea', -> $(this).dynDateTime()
	$('.formitem .datetime').on 'click', -> $(this).dynDateTime()

	height = Math.floor($('#main .content').height()/40)+18
	if ($('.main-menu-span .well ul li').size() > height)
		$('.main-menu-span .well ul li:gt('+height+')').slideToggle();
		$('.main-menu-span .well ul li:eq('+height+')').after('<li> <a href="#" id="more">查看更多....</a></li>');
		$('.main-menu-span .well ul li a#more').on 'click', ->
			$('.main-menu-span .well ul li:gt('+height+')').slideToggle()
			false
		false

	$('.tablescroll').on 'click', '.edit_checkbox', ->
		$(this).parents('tr').toggleClass('selection')
		checked_status()

	$('.tablescroll').on 'click', '.deselect', ->
		$('.tablescroll .edit_checkbox:checked').attr('checked', false)
		checked_status()
		for input_check in $('.tablescroll .edit_checkbox')
			do (input_check) -> $(input_check).parents('tr').removeClass("selection")
		false

	$('.tools_box .tool_02').on 'click', ->
		return false if $(this).attr('disabled')
		if($('.tablescroll .edit_checkbox:checked').length > 0 && window.confirm("确定要删除么?"))
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


	$('#seaerch-T').on
		change: ->
			search_input_change()
		keyup: ->
			search_input_change()

	search_input_change()



	for input_check in $('.tablescroll .edit_checkbox:checked')
		do (input_check) -> $(input_check).parents('tr').addClass("selection")



	$('#toggle_check').on 'click', ->
		$('input.edit_checkbox').prop('checked', $(this).is(":checked"))
		if ($(this).is(":checked"))
			$('input.edit_checkbox').parents('tr').addClass('selection')
		else
			$('input.edit_checkbox').parents('tr').removeClass('selection')
		checked_status()
		
	# back top
	$('#layout_scrolltop').on 'click', -> $("html, body").animate({ scrollTop: 0 }, 120);

	# $(window).on 'scroll', -> $('#layout_scrolltop').css('visibility', $(window).scrollTop() > 500 ? 'visible' : 'hidden');

	# 检查选择状态
	checked_status()
	# 
	hidden_input_select_with_name()


	# 已经显示的条件 在下拉框里不可点击
	$('#select_field option').each -> $(this).attr('disabled', 'disabled') if $('#current_condition').val().split(',').indexOf($(this).val()) >= 0
		
	# 刷新后没有选中的复选框 隐藏后台的查询条件框
	$('.check_edit[style=""] .check_box_edit').each -> $('.span3', $(this).parents('div.check_edit')).hide() if !$(this).is(":checked")
		
	false

$ ->
	$(document).on 'mousedown', '.color', ->
		$('body').removeClass('bgcolor1 bgcolor2 bgcolor3 bgcolor4 bgcolor5 bgcolor6 bgcolor7 bgcolor8 bgcolor9 bgcolor10 bgcolor11 bgcolor12 bgcolor13 bgcolor14 bgcolor15 bgcolor16 bgcolor17 bgcolor18 bgcolor19 bgcolor20').addClass($(this).text().toLowerCase())
		$.cookie 'document_color', $(this).text().toLowerCase(),
			expires: 30
			path: '/'
	if color = $.cookie('document_color')
		$('body').removeClass('bgcolor1 bgcolor2 bgcolor3 bgcolor4 bgcolor5 bgcolor6 bgcolor7 bgcolor8 bgcolor9 bgcolor10 bgcolor11 bgcolor12 bgcolor13 bgcolor14 bgcolor15 bgcolor16 bgcolor17 bgcolor18 bgcolor19 bgcolor20').addClass(color)

