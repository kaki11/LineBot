class LineUser < ApplicationRecord
  validates :line_id, presence: true
  belongs_to :user
end
