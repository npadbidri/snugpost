$(document).ready(function(){
	$("#search").focus(function(){
		if ($(this).val()=="search...")
			{
				$(this).val("");
			}
	});
	$("#search").blur(function(){
		if ($(this).val()=="")
			{
				$(this).val("search...");
			}
	});
});
