class AddCountersToAllTables < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :categories_count, :integer, default: 0
    add_column :users, :purchases_count, :integer, default: 0
    add_column :categories, :purchase_categories_count, :integer, default: 0
    add_column :purchases, :purchase_categories_count, :integer, default: 0

    User.find_each do |user|
      User.reset_counters(user.id, :categories)
      User.reset_counters(user.id, :purchases)
    end

    Category.find_each do |category|
      Category.reset_counters(category.id, :purchase_categories)
    end

    Purchase.find_each do |purchase|
      Purchase.reset_counters(purchase.id, :purchase_categories)
    end
  end
end
