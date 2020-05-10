class Post < ApplicationRecord
  validates :title, presence: true, uniqueness: true
  validates :author, presence: true
  validates :caption, presence: true, length: { maximum: 200 }
end