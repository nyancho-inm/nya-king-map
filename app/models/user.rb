class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, uniqueness: true
  VALID_PASSWORD_REGEX = /([0-9].*[a-zA-Z]|[a-zA-Z].*[0-9])/.freeze
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'は英語と数字を使用してください' }
  validates :nickname, presence: true

  has_many :cats
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy


  def liked_by?(cat_id)
    likes.where(cat_id: cat_id).exists?
  end
end
