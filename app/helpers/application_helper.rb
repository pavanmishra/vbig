# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  FeaturedCauses = ['Environment', 'Poverty']
  FeaturedSkills = ['Social Media', 'Writing']
  
  def fboauth_connect_async_js(app_id,options={})
    opts = Hash.new(true).merge!(options)
    cookie = opts[:cookie]
    status = opts[:status]
    xfbml = opts[:xfbml]
    js = <<-JAVASCRIPT

      <script>
        window.fbAsyncInit = function() {
          FB.init({
            appId  : '#{app_id}',
            status : #{status}, // check login status
            cookie : #{cookie}, // enable cookies to allow the server to access the session
            xfbml  : #{xfbml}  // parse XFBML
          });
        };
      
        (function() {
          var e = document.createElement('script');
          e.src = document.location.protocol + '//connect.facebook.net/en_US/all.js';
          e.async = true;
          document.getElementById('fb-root').appendChild(e);
        }());
      </script>
      JAVASCRIPT
  end
  
  def fboauth_login_and_redirect(url, options = {})
    js = "window.location.href='#{url}';"

   text = options.delete(:text)
   
   content_tag("fb:login-button",text,options.merge(:onlogin=>js))
 end
 
 def facebook_profile_picture(user, type='small')
   type.eql?('small') ? user.pic_square : user.profile_url.gsub('www', 'graph') + "/picture?type=#{type}" rescue ''
 end
    
end
