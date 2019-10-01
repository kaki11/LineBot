class Topic < ApplicationRecord

  validates :user_id, presence: true
  validates :send_message, presence: true, length: { maximum: 150 }
  validates :receive_message, presence: true, length: { maximum: 150 }

  belongs_to :user
  default_scope -> { order(created_at: :desc) }
end
