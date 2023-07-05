class Purchase < ApplicationRecord
  belongs_to :author, class_name: 'User', counter_cache: true
  has_many :purchase_categories, dependent: :destroy

  validates :name, presence: true
  validates :amount, presence: true
end
