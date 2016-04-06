require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "welcome_email" do
    # Send the email, then test that it got queued
    email = UserMailer.create_welcome_email('friend@example.com', Time.now).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?

    # Test the body of the sent email contains what we expect it to
    assert_equal ['me@example.com'], email.from
    assert_equal ['friend@example.com'], email.to
    assert_equal 'Welcome to MagicMic', email.subject
    assert_equal read_fixture('invite').join, email.body.to_s
  end
end

