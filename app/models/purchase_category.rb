class PurchaseCategory < ApplicationRecord
  belongs_to :purchase, counter_cache: true
  belongs_to :category, counter_cache: true
end
