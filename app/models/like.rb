class Like < ApplicationRecord
  belongs_to :user
  belongs_to :cat

  validates :user_id, {presence: true}
  validates :cat_id, {presence: true}
end
