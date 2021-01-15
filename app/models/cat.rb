class Cat < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user
  has_one_attached :image
  
  with_options presence: true do
    validates :prefecture_id
    validates :area
    validates :image
  end
  validates :prefecture_id, numericality: { other_than: 0, message: 'は--以外を選んでください' }

  
end
