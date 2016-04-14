class UserMailer < ActionMailer::Base
  default from: "Harry's <welcome@harrys.com>"

  def signup_email(user)
    @user = user
    @twitter_message = "•	Get Your Free Cannabis Birthday Cake. Premium Edibles. I can’t wait to get my Free Marijuana Birthday Cake for my birthday. "

    mail(:to => user.email, :subject => "Thanks for signing up!")
  end
end
