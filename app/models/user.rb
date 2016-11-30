require 'users_helper'

class User < ActiveRecord::Base
  belongs_to :referrer, class_name: 'User', foreign_key: 'referrer_id'
  has_many :referrals, class_name: 'User', foreign_key: 'referrer_id'

  validates :email, presence: true, uniqueness: true, format: {
    with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/i,
    message: 'Invalid email format.'
  }
  validates :referral_code, uniqueness: true

  before_create :create_referral_code
  after_create :send_welcome_email



                     REFERRAL_STEPS = [
    {
      'count' => 5,
      'html' => '1st drink free',
      'class' => 'two',
      'image' =>  ActionController::Base.helpers.asset_url(
        'assets/refer/1/discount.jpg')
    },
    {
      'count' => 10,
      'html' => '1 Month free',
      'class' => 'three',
      'image' => ActionController::Base.helpers.asset_url(
        'assets/refer/2/3-cupcakes.jpg')
    },
    {
      'count' => 25,
      'html' => 'you will be invited to our exclusive launch party',
      'class' => 'four',
      'image' => ActionController::Base.helpers.asset_url(
        'assets/refer/3/Gourmet-Cupcakes.jpg')
    },
    {
      'count' => 50,
      'html' => '1 year free membership',
      'class' => 'five',
      'image' => ActionController::Base.helpers.asset_url(
        'assets/refer/4/finalimg.jpg')
    }
  ]

  private

  def create_referral_code
    self.referral_code = UsersHelper.unused_referral_code
  end

  def send_welcome_email
    UserMailer.delay.signup_email(self)
  end
end
