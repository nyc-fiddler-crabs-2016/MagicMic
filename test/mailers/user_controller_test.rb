class UserControllerTest < ActionController::TestCase
  test "welcome_email" do
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      post :welcome_email, email: 'friend@magicmic.com'
    end
    welcome_email = ActionMailer::Base.deliveries.last

    assert_equal 'Welcome to MagicMic', invite_email.subject
    assert_equal 'friend@magicmic.com', welcome_email.to[0]
    assert_match(/Welcome to magicmic.com/, welcome_email.body.to_s)
  end
end
