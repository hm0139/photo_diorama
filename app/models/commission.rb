class Commission < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :title
    validates :description
    validates :limit_date
    validates :reward, numericality: { in: 5000..200000 }
  end
  validates :directly, inclusion: [true, false]
  validate :date_before_start

  private
  def date_before_start
    return if limit_date.blank?
    errors.add(:start_day, "は一週間以上先のものを選択してください") if limit_date < Date.today + 7
  end
end
