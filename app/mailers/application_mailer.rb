class ApplicationMailer < ActionMailer::Base
  default from: "from@http://magic-mic.herokuapp.com/"
  layout 'mailer'
end
