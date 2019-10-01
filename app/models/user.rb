class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 15 }
  validates :email, uniqueness: true, format: { with:/\A\S+@\S+\.\S+\z/ }
  validates :password, confirmation: true, length: { in: 8..32 }, format: { with:/(?=.*?[a-zA-Z])(?=.*?\d)[\w]/ },
              allow_nil: true # →　対象の値がnilの場合にバリデーションをスキップ

  has_secure_password
  has_many :topics, dependent: :destroy
end
