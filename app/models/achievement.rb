class Achievement < ApplicationRecord
  belongs_to :user
  has_many_attached :images

  FILE_NUMBER_LIMIT = 5

  with_options presence: true do
    validates :achievement_text
    validates :text
  end

  validate :validate_number_of_files

  private
  def validate_number_of_files
    return if images.length <= FILE_NUMBER_LIMIT
    errors.add(:images, "を添付できる枚数は#{FILE_NUMBER_LIMIT}枚までです。")
  end
end
