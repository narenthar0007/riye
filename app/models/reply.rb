class Reply < ApplicationRecord
  belongs_to :daily_update
  belongs_to :user

  has_one_attached :image

  validates :content, presence: true, unless: :image_attached?

  validate :content_or_image_present

  private

  def image_attached?
    image.attached?
  end

  def content_or_image_present
    unless content.present? || image.attached?
      errors.add(:base, "Either content or image must be present")
    end
  end
end
