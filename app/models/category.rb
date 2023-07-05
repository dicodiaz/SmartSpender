class Category < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_many :purchase_categories, dependent: :destroy

  validates :name, presence: true
  validates :icon, presence: true

  def total_purchases
    purchase_categories.size
  end

  def total_amount
    purchase_categories.includes(:purchase).reduce(0) do |sum, purchase_category|
      sum + purchase_category.purchase.amount
    end
  end
end
