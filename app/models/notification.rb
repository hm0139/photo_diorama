class Notification < ApplicationRecord
  belongs_to :commission
  belongs_to :user
end
