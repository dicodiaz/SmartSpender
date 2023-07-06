class Category < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_many :purchase_categories
  has_many :purchases, through: :purchase_categories, dependent: :destroy

  validates :name, presence: true
  validates :icon, presence: true

  def total_purchases
    purchase_categories.size
  end

  def total_amount
    purchases.reduce(0) { |sum, purchase| sum + purchase.amount }
  end
end
