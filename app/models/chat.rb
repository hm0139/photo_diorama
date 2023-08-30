class Chat < ApplicationRecord
  belongs_to :dealing
  belongs_to :user
  has_many_attached :images

  FILE_NUMBER_LIMIT = 3

  validates :post_text, presence: true, unless: :was_attached?
  validate :validate_number_of_files

  after_create_commit { MessageBroadcastJob.perform_later self }

  private
  def validate_number_of_files
    return if images.length <= FILE_NUMBER_LIMIT
    errors.add(:images, "を添付できる枚数は#{FILE_NUMBER_LIMIT}枚までです。")
  end

  def was_attached?
    self.images.attached?
  end
end
