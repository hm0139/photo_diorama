class Chat < ApplicationRecord
  belongs_to :dealing
  belongs_to :user
end
