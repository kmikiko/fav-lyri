class ApplicationMailer < ActionMailer::Base
  default from: ENV["MAIL"]
  layout 'mailer'
end
