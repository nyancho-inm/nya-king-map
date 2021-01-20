class Cat < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to :user
  has_many_attached :images
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  with_options presence: true do
    validates :prefecture_id
    validates :area
    validates :images
  end
  validates :prefecture_id, numericality: { other_than: 0, message: 'は--以外を選んでください' }

  def self.search(search)
    if search != ""
      Cat.where('area LIKE(?) OR prefecture_id LIKE(?) OR message LIKE(?) OR place LIKE(?)',
                 "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
    else
      Cat.all
    end
  end
  
end
