module PurchasesHelper
  def total_amount(purchases)
    purchases.reduce(0) { |sum, purchase| sum + purchase.amount }
  end
end
