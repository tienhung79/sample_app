class User < ApplicationRecord
  validates :name, presence: true,
    length: {maximum: Settings.digits.length_50}

  validates :email, presence: true,
    length: {maximum: Settings.digits.length_255},
    format: {with: Settings.digits.regex}, uniqueness: true

  validates :password, presence: true,
    length: {minimum: Settings.digits.length_6}, allow_nil: true

  has_secure_password

  before_save :down_case
  attr_accessor :remember_token

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost:
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def forget
    update_column :remember_digest, nil
  end

  def authenticated? remember_token
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  private

  def down_case
    email.downcase!
  end
end
