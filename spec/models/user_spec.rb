require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.create(name: 'user name', email: 'user_email@mail.com', password: 'user_password') }

  context '#select_categories' do
    before(:each) do
      @category = Category.create(name: 'category name', icon: 'category icon', user:)
      @category2 = Category.create(name: 'category2 name', icon: 'category2 icon', user:)
    end

    it 'should return an array with a title as first element and an information array as second element' do
      categories = user.select_categories
      expect(categories).to eq([['Categories', [[@category.name, @category.id], [@category2.name, @category2.id]]]])
    end
  end
end
