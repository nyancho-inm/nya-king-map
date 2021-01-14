class Cat < ApplicationRecord
  with_options presence: true do
    validates :prefecture_id
    validates :area
  end

  belongs_to :user
  has_one_attached :image
end
