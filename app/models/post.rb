class Post < ApplicationRecord
  belongs_to :user
  attachment :post_image
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  validates :name, presence: true, length: { maximum: 30 }
  validates :category, presence: true, length: { maximum: 10 }
  validates :caption, presence: true, length: { maximum: 500 }
end
