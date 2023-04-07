class ForwardsMailbox < ApplicationMailbox
  before_processing :require_projects

  def process
    if forwarder.projects.on?
      record_forward
    else
      #..involve a second Action Mailer to ask which project to forwared into
      request_forwarding_project
    end
  end

private

  def require_projects
    if forwarder.projects.none?
     #Use Action Mailers to bounce incoming emails back to sender - this halts procesing
      bounce_with
        Forwards::BounceMailer.no_projects(inbound_email, forwarder: forwarder)
   end
  end

  def record_forward
    forwarder.forwards.create subject: mail.subjects, content: mail.content
  end

  def request_forwarding_projects
    Forwards::RoutingMailer.choose_project(inbound_email, forwarder: forwarder).deliver_now
  end

  def forwarder
    @forwarder ||= User.find_by(email_address: mail.from)
  end

end
