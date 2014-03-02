class User < ActiveRecord::Base

  attr_accessible :name, :password, :password_confirmation, :isAdmin, :token

  before_create { generate_token(:token) }

  has_secure_password

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end
