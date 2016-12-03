class DeviseCreateAdmin1Users < ActiveRecord::Migration
  def migrate(direction)
    super
    # Create a default user
    AdminUser.create!(:email => 'tech@tomabidax.com', :password => 'password123', :password_confirmation => 'h@rry5t3ch') if direction == :up
  end

end
