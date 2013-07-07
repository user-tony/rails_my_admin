$(function(){
  $('.editable').map(function(){
    $(this).data('original', $(this).attr('data-title'));
  });
  $('.editable').editable(function(value, settings) {
    $(this).data('value', value);
    if (value == $(this).data('original')) return value.substring(0,10) + "..";
    params = $(this).data('params') || {};
    params["value"] = value;
    params["field"] = $(this).data('field');
    params["table"] = $(this).data('table');
    $.ajax({
      url: $(this).data('url'),
      type: 'put',
      dataType: 'html',
      data: params,
      context: this,
      beforeSend: function(){ $(this).html('<img src="/assets/loading.gif" style="width:16px;height:16px;" />'); },
      success: function(){ $(this).html((h = $(this).data('value').substring(0,10) + "..") && h != '' ? h : settings['placeholder']); $(this).data('original', $(this).data('value')); $(this).attr('data-title', $(this).data('value')); },
      error: function(){ $(this).html((h = $(this).data('original')) && h != '' ? h : settings['placeholder']); alert('提交失败'); }
    });
  }, {
    data: function(){ return $(this).data('original'); },
    submit: '✔',
    cancel: '✘',
    type: 'textarea',
    placeholder: '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;',
    tooltip: '点击修改...',
    onblur: 'ignore'
  });
})