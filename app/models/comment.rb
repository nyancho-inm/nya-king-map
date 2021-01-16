class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :cat

  validates :text, presence: true
end
