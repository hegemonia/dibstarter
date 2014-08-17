class DibPlacementMailer < ActionMailer::Base
  default from: "admin@dibstarter.com"

  def send_dib_placed_email(dib)
    @user = dib.user
    mail(to: @user.email, subject: "You've placed a dib!")
  end
end
