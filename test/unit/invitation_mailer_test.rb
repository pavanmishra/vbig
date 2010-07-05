require 'test_helper'

class InvitationMailerTest < ActionMailer::TestCase
  test "invite" do
    @expected.subject = 'InvitationMailer#invite'
    @expected.body    = read_fixture('invite')
    @expected.date    = Time.now

    assert_equal @expected.encoded, InvitationMailer.create_invite(@expected.date).encoded
  end

end
