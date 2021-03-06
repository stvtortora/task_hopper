class User < ApplicationRecord
  validates :username, :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: {minimum: 6, allow_nil: true}
  attr_reader :password
  after_initialize :ensure_session_token

  has_attached_file :image, default_url: "bunny.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    if user
      return user if user.is_password?(password)
    end
    nil
  end

  def self.types
    ["Client", "Tasker"]
  end

  def reset_session_token
    puts 'setting session token'
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
    self.session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end

end
