class Category < ApplicationRecord
  belongs_to :user
  has_many :purchase_categories
end
