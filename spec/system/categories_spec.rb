require 'rails_helper'

RSpec.describe 'Categories', type: :system do
  before(:each) do
    @user = User.create(name: 'user name', email: 'user_email@mail.com', password: 'user_password')
    login_as(@user, scope: :user)
  end

  describe 'index page' do
    before(:each) do
      @category = Category.create(name: 'category name', icon: '/assets/placeholder.png', user: @user)
      @purchase = Purchase.new(name: 'purchase name', amount: 1.0, author: @user)
      @purchase.categories << @category
      @purchase.save
      visit categories_path
    end

    it "displays a 'CATEGORIES' heading" do
      expect(page).to have_content('CATEGORIES')
    end

    it "displays a clickable card with the category's information that redirects to purchases#index" do
      expect(page).to have_css("img[src*='#{@category.icon}']")
      expect(page).to have_content(@category.name)
      expect(page).to have_content("#{@category.total_purchases} purchase")
      expect(page).to have_content("$#{@category.total_amount}")
      click_link(@category.name)
      expect(page).to have_current_path(purchases_path(category_id: @category.id))
    end

    it "displays a 'ADD NEW CATEGORY' link that redirects to categories#new" do
      click_link('ADD NEW CATEGORY')
      expect(page).to have_current_path(new_category_path)
    end
  end

  describe 'new page' do
    before(:each) { visit new_category_path }

    it "displays a 'NEW CATEGORY' heading" do
      expect(page).to have_content('NEW CATEGORY')
    end

    it "displays a 'back_to_categories' link that redirects to categories#index" do
      click_link('back_to_categories')
      expect(page).to have_current_path(categories_path)
    end

    it 'displays all expected labels' do
      expect(page).to have_content('Name')
      expect(page).to have_content('Icon')
    end

    it "displays an 'Add' button that creates the category and redirects to categories#index" do
      fill_in('category_name', with: 'category name')
      fill_in('category_icon', with: '/assets/placeholder.png')
      expect do
        click_button('Add')
        sleep(0.5)
      end.to change(Category, :count).by(1)
      expect(page).to have_current_path(categories_path)
    end
  end
end
