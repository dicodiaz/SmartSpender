class Purchase < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :purchase_categories
end
