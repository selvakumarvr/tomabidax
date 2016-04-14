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
      'count' => 10,
      'html' => '$10 Discount <BR> On Any Premium <BR>Baked Edibles',
      'class' => 'two',
      'image' =>  ActionController::Base.helpers.asset_path(
        'refer/1/discount.jpg')
    },
    {
      'count' => 30,
      'html' => '3 FREE Cana Cupcakes<br> & $10 Discount<br>On Cana Birthday Cake',
      'class' => 'three',
      'image' => ActionController::Base.helpers.asset_path(
        'refer/2/3-cupcakes.jpg')
    },
    {
      'count' => 100,
      'html' => '5 FREE Cana Cupcakes <br> & $20 Discount On <br> Cana Birthday Cake',
      'class' => 'four',
      'image' => ActionController::Base.helpers.asset_path(
        'refer/3/Gourmet-Cupcakes.jpg')
    },
    {
      'count' => 500,
      'html' => 'FREE 15 pc. Cannabis <br>Birthday Cake Valued <br>At $150.00',
      'class' => 'five',
      'image' => ActionController::Base.helpers.asset_path(
        'refer/4/finalimg.jpg')
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
