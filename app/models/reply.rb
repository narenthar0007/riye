class Reply < ApplicationRecord
  belongs_to :daily_update
  belongs_to :user
  
  # Active Storage attachments
  has_one_attached :image
  
  # Validations
  validates :content, presence: true, unless: :image_attached?
  validates :image, content_type: ['image/png', 'image/jpg', 'image/jpeg', 'image/gif', 'image/webp'],
                    size: { less_than: 5.megabytes, message: 'must be less than 5MB' }
  
  # Ensure at least content or image is present
  validate :content_or_image_present
  
  private
  
  def image_attached?
    image.attached?
  end
  
  def content_or_image_present
    unless content.present? || image.attached?
      errors.add(:base, 'Either content or image must be present')
    end
  end
end
