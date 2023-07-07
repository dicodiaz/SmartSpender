require 'rails_helper'

RSpec.describe Category, type: :model do
  before(:each) do
    @user = User.create(name: 'user name', email: 'user_email@mail.com', password: 'user_password')
    @category = Category.create(name: 'category name', icon: 'category icon', user: @user)
  end

  context 'validations' do
    it('should be valid') do
      expect(@category).to be_valid
    end

    it 'should be invalid when name is not present' do
      @category.name = nil
      expect(@category).not_to be_valid
    end

    it 'should be invalid when icon is not present' do
      @category.icon = nil
      expect(@category).not_to be_valid
    end
  end

  context 'methods' do
    before(:each) do
      @purchase = Purchase.new(name: 'purchase name', amount: 1.0, author: @user)
      @purchase.categories << @category
      @purchase.save
      @purchase2 = Purchase.new(name: 'purchase2 name', amount: 1.5, author: @user)
      @purchase2.categories << @category
      @purchase2.save
    end

    it '#total_purchases should return the count of purchases for the given category' do
      expect(@category.total_purchases).to eq(2)
    end

    it "#total_amount should return the sum of all purchases' amounts for the given category" do
      expect(@category.total_amount).to eq(@purchase.amount + @purchase2.amount)
    end
  end
end
