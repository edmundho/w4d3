class User < ApplicationRecord
  before_validation :ensure_session_token

  has_many :requests,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "CatRentalRequest"
    
  has_many :cats,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :Cat
  
  def ensure_session_token
    self.session_token ||= SecureRandom.urlsafe_base64
  end
  
  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save
    self.session_token
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def self.find_by_credentials(user_name, password)
    @user = User.find_by(username: user_name)
    return nil if @user.nil?
    if @user.is_password?(password)
      @user
    end
  end
end