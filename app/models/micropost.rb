class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  scope :newest, ->{order created_at: :desc}

  validates :content, presence: true,
length: {maximum: Settings.digits.length_140}
  validates :image, content_type: {in: Settings.format_image,
                                   message: I18n.t("format_image")},
size: {less_than: 5.megabytes, message: I18n.t("size_image")}
end
