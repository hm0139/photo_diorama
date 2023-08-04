class Chat < ApplicationRecord
  belongs_to :dealing
  belongs_to :user
  has_many_attached :images

  FILE_NUMBER_LIMIT = 3

  validates :post_text, presence: true
  validate :validate_number_of_files

  private
  def validate_number_of_files
    return if images.length <= FILE_NUMBER_LIMIT
    errors.add(:images, "に添付できる画像は#{FILE_NUMBER_LIMIT}件までです。")
  end
end
