class User < ApplicationRecord
  validates :name, presence: true,
    length: {maximum: Settings.digits.length_50}

  validates :email, presence: true,
    length: {maximum: Settings.digits.length_255},
    format: {with: Settings.digits.regex}, uniqueness: true

  has_secure_password

  before_save :down_case

  private

  def down_case
    email.downcase!
  end
end
