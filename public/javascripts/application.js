// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function attended(){
	$('attended_message').show();
	$('not_attended_message').hide();
	$('attended_hours').show();
	$('event_user_comment').value = 'It was fantastic and felt.';	
}
function not_attended(){
	$('attended_message').hide();
	$('not_attended_message').show()
	$('attended_hours').hide();
	$('event_user_comment').value = 'I was ill. But I did get to hear from my friends that it was fantastic.';
}

function login_signup_facebook(){
	FB.login(function(response){ alert(response)},
	{}
	)
}
