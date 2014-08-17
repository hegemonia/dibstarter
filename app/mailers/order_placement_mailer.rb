class OrderPlacementMailer < ActionMailer::Base
  default from: "admin@dibstarter.com"

  def send_order_placed_email(dib)
    @user = dib.user
    @dib_name = dib.product.name
    mail(to: @user.email, subject: "Your dib has been ordered!")
  end
end
