class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :name, uniqueness: true,
                   length: { maximum:30 }

end
