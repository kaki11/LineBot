class LineUser < ApplicationRecord
  validates :line_id, presence: true
  belongs_to :user

  def get_token
  end

  def user_info
  end
  
end
