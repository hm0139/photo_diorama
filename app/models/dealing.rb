class Dealing < ApplicationRecord
  belongs_to :user
  belongs_to :commission
  has_many :chats
end
