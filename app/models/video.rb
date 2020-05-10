class Video < ApplicationRecord
  validates :title, presence: true
  validates :author, presence: true
  validates :caption, presence: true, length: { maximum: 200 }
end