class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  # scope :newest, -> { order(created_at: :desc) }
  scope :newest, -> {order created_at: :desc}
  scope :relate_post, ->(user_ids){where user_id: user_ids}

  validates :content, presence: true, length: {maximum: Settings.digits.length_140}
  validates :image, content_type: {in: %w[image/jpeg image/gif image/png],
                                      message: "must be a valid image format"},
                    size: {less_than: 5.megabytes,
                                      message: "should be less than 5MB"}

  def display_image
    image.variant resize_to_limit: [500, 500]
  end
end
