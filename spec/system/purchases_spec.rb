require 'rails_helper'

RSpec.describe 'Purchases', type: :system do
  before(:each) do
    @user = User.create(name: 'user name', email: 'user_email@mail.com', password: 'user_password')
    @category = Category.create(name: 'category name', icon: '/assets/placeholder.png', user: @user)
    @purchase = Purchase.new(name: 'purchase name', amount: 1.0, author: @user)
    @purchase.categories << @category
    @purchase.save
    login_as(@user, scope: :user)
  end

  describe 'index page' do
    before(:each) { visit purchases_path(category_id: @category.id) }

    it "displays a 'PURCHASES' heading" do
      expect(page).to have_content("PURCHASES - #{@category.name} ($#{@category.total_amount})")
    end

    it "displays a 'back_to_categories' link that redirects to categories#index" do
      click_link('back_to_categories')
      expect(page).to have_current_path(categories_path)
    end

    it "displays a card with the purchase's information" do
      expect(page).to have_css("img[src*='#{@category.icon}']")
      expect(page).to have_content(@category.name)
      expect(page).to have_content(@category.created_at.strftime('%d %b %Y'))
      expect(page).to have_content("$#{@category.total_amount}")
    end

    it "displays a 'ADD NEW PURCHASE' link that redirects to purchases#new" do
      click_link('ADD NEW PURCHASE')
      expect(page).to have_current_path(new_purchase_path(category_id: @category.id))
    end
  end

  describe 'new page' do
    before(:each) { visit new_purchase_path(category_id: @category.id) }

    it "displays a 'NEW PURCHASE' heading" do
      expect(page).to have_content('NEW PURCHASE')
    end

    it "displays a 'back_to_purchases' link that redirects to purchases#index" do
      click_link('back_to_purchases')
      expect(page).to have_current_path(purchases_path(category_id: @category.id))
    end

    it 'displays all expected labels' do
      expect(page).to have_content('Name')
      expect(page).to have_content('Amount')
      expect(page).to have_content('Category')
    end

    it "displays an 'Add' button that creates the purchase and redirects to purchases#index" do
      fill_in('purchase_name', with: 'purchases name')
      fill_in('purchase_amount', with: '1')
      expect do
        click_button('Add')
        sleep(0.5)
      end.to change(Purchase, :count).by(1)
      expect(page).to have_current_path(purchases_path)
    end
  end
end
