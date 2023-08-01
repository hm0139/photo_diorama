class Commission < ApplicationRecord
  belongs_to :user
  has_one :notification
  has_one :dealing

  with_options presence: true do
    validates :title
    validates :description
    validates :limit_date
    validates :reward, numericality: { in: 5000..1000000 }
  end
  validates :directly, inclusion: [true, false]
  validate :date_before_start

  def self.search(search)
    if search != ""
      Commission.where("title LIKE(?)", "%#{search}%").where(directly: false).where(status: Commission.statuses[:undealt])
    else
      Commission.where(directly: false).where(status: Commission.statuses[:undealt])
    end
  end

  private
  def date_before_start
    return if limit_date.blank?
    errors.add(:limit_date, "は一週間以上先のものを選択してください") if limit_date < Date.today + 7
  end

  enum status:{undealt: 0, dealing: 1, dealed: 2, unsuccessful: 3}
end
