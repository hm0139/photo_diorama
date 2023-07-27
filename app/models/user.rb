class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :commissions
  has_many :notifications

  with_options presence: true do
    validates :user_name
    validates :name
    validates :reading_name, format: {with: /\A[ァ-ヴー]+\z/, message: "は全角カタカナで記入してください"}
    validates :postal_code, format: {with: /\A\d{3}-\d{4}\z/, message: "が正しくありません"}
    validates :prefectures, numericality: {other_than: 0}
    validates :city
  end

  #注 : 以下のバリデーションは空白を許可
  validates :deposit, numericality: true
  validates :account_number, format: {with: /\A\d{4,7}\z|\A\z/ , message: "は正しく入力してください"}
  validates :account_holder, format: {with: /\A[ァ-ヴー]+\z|\A\z/, message: "は全角カタカナで記入してください"}

  enum kinds: {requester: 0, creator: 1}
end
