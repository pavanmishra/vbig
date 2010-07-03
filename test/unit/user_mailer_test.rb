require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "welcome_facebook_user" do
    @expected.subject = 'UserMailer#welcome_facebook_user'
    @expected.body    = read_fixture('welcome_facebook_user')
    @expected.date    = Time.now

    assert_equal @expected.encoded, UserMailer.create_welcome_facebook_user(@expected.date).encoded
  end

end
