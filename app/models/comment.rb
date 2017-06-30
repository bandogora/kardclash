class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :declaration
  has_paper_trail
  validates :text, presence: true
  validates :user_id, presence: true
  validates :declaration_id, presence: true
end
