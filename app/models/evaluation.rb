class Evaluation < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :commission

  validates :rank, presence: true, numericality: {other_than: 0}
end
