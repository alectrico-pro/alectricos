class ApplicationMailer < ActionMailer::Base
  default from: DEFAULT_FROM
  layout 'mailer_layout'
end
