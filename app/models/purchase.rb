class Purchase < ApplicationRecord
  belongs_to :author, class_name: 'User', counter_cache: true
  has_many :purchase_categories
  has_many :categories, through: :purchase_categories, dependent: :destroy

  validates :name, presence: true
  validates :amount, presence: true
  validates :categories, length: { minimum: 1 }
end
