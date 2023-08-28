class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, presence: true,
length: {maximum: Settings.digits.length_50}

  validates :email, presence: true,
  length: {maximum: Settings.digits.length_255},
  format: {with: VALID_EMAIL_REGEX}, uniqueness: true

  has_secure_password

  before_save :down_case

  private

  def down_case
    email.downcase!
  end
end
