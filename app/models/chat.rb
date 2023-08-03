class Chat < ApplicationRecord
  belongs_to :dealing
  belongs_to :user

  validates :post_text, presence: true
end
