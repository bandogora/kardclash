class Declaration < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_paper_trail
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 5, maximum: 300 }
  validates :user_id, presence: true
end
