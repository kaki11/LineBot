class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 15 }
  validates :email, uniqueness: true, format: { with:/\A\S+@\S+\.\S+\z/ }
  validates :password, confirmation: true, length: { in: 8..32 }, format: { with:/(?=.*?[a-zA-Z])(?=.*?\d)[\w]/ }

  has_secure_password
end
