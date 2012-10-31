class Mailer < ActionMailer::Base

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mailer.invitation.subject
  #
 def invitation(invitation, signup_url)
   puts signup_url
   sleep(5)
    subject    'Join the Digital Library Development Management tool'
    recipients invitation.recipient_email
    from       'foo@example.com'
    body      " You are invited to join the beta at " + signup_url 
    invitation.update_attribute(:sent_at, Time.now)
  end
end
