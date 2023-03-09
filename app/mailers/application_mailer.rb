class ApplicationMailer < ActionMailer::Base
  default from: "'Standup App' <Standups@standup-app.com>"
  layout 'bootstrap-mailer'
end
