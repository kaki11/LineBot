class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 15 }
  validates :email, presence: true, uniqueness: true, format: { with:/\A\S+@\S+\.\S+\z/ }
  validates :password, presence: true, confirmation: true, length: { in: 8..32 }, format: { with:/(?=.*?[a-zA-Z])(?=.*?\d)[\w]/ },
              allow_nil: true

  has_secure_password
  has_many :topics, dependent: :destroy
  has_one :line_user
end
