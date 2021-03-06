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
//= require jquery_ujs
//= require codemirror
//= require sql
//= require develop/manages
//= require jquery/jquery.jeditable
//= require jquery/editable
//= require jquery/jquery.cookie
//= require jquery/jquery.color
//= require jquery/dyndatetime/dynDateTime
//= require jquery/dyndatetime/calendar_zh
//= require js/messenger.min



$._messengerDefaults = {
	extraClasses: 'messenger-fixed messenger-theme-air messenger-on-top'
}

function message_show(msg, msg_type){
	msg_type = 'notice'
	$.globalMessenger().post({
	  message: msg,
	  type: msg_type,
	  showCloseButton: true
	});
}

