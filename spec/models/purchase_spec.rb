require 'rails_helper'

RSpec.describe Purchase, type: :model do
  before(:each) do
    @user = User.create(name: 'user name', email: 'user_email@mail.com', password: 'user_password')
    @purchase = Purchase.create(name: 'purchase name', amount: 1.0, author: @user)
    @category = Category.create(name: 'category name', icon: 'category icon', user: @user)
    @purchase.categories << @category
  end

  context 'validations' do
    it('should be valid') do
      expect(@purchase).to be_valid
    end

    it 'should be invalid when name is not present' do
      @purchase.name = nil
      expect(@purchase).not_to be_valid
    end

    it 'should be invalid when amount is not present' do
      @purchase.amount = nil
      expect(@purchase).not_to be_valid
    end

    it 'should be invalid when no category is present' do
      @purchase.categories.clear
      expect(@purchase).not_to be_valid
    end
  end
end
