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

function popitup(url){
	newwindow=window.open(url,'name','height=300,width=450');
	if (window.focus) {newwindow.focus()}
		return false;
}

function post_to_facebook(){
	FB.ui(
	  {
	    method: 'stream.publish',
	    attachment: {
	      name: 'JSSDK',
	      caption: 'The Facebook JavaScript SDK',
	      description: (
	        'A small JavaScript library that allows you to harness ' +
	        'the power of Facebook, bringing the user\'s identity, ' +
	        'social graph and distribution power to your site.'
	      ),
	      href: 'http://cvb.socialsync.org/'
	    },
	    action_links: [
	      { text: 'fbrell', href: 'http://cvb.socialsync.org/' }
	    ]
	  },
	  function(response) {
	    if (response && response.post_id) {
	      alert('Post was published.');
	    } else {
	      alert('Post was not published.');
	    }
	  }
	);
	
}
function login_signup_facebook(){
	FB.login(function(response){ 
		if(response.session){
//			alert(response.session)
			var details = "*****************" + "\n" + message + "\n";
			  var fieldContents;
			  for (var field in response) {
			    fieldContents = obj[field];
			    if (typeof(fieldContents) == "function") {
			      fieldContents = "(function)";
			    }
			    details += "  " + field + ": " + fieldContents + "\n";
			  }
			  alert(details);
			
		}else{
			alert('there was problem, logging into the system. Please try again after sometime.')
		}
		},
	{perms:'email'}
	)
}
