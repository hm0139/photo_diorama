class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :commissions
  has_many :notifications
  has_many :dealings
  has_one :achievement
  has_many :chats

  with_options presence: true do
    validates :user_name
    validates :name
    validates :reading_name, format: {with: /\A[ァ-ヴー]+\z/, message: "は全角カタカナで記入してください"}
    validates :postal_code, format: {with: /\A\d{3}-\d{4}\z/, message: "が正しくありません"}
    validates :prefectures, numericality: {other_than: 0}
    validates :city
    validates :kind, inclusion: [0,1]
  end

  #注 : 以下のバリデーションは空白を許可
  validates :deposit, numericality: true
  validates :account_number, format: {with: /\A\d{4,7}\z|\A\z/ , message: "は正しく入力してください"}
  validates :account_holder, format: {with: /\A[ァ-ヴー]+\z|\A\z/, message: "は全角カタカナで記入してください"}

  def self.search(user_name)
    if user_name != ""
      User.where("user_name LIKE(?)", "%#{user_name}%").where(kind: 1)
    else
      User.where(kind: 1)
    end
  end
  #enum kind: {requester: 0, creator: 1}
end
