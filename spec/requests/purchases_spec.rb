require 'rails_helper'

RSpec.describe '/purchases', type: :request do
  before(:each) do
    @user = User.create(name: 'user name', email: 'user_email@mail.com', password: 'user_password')
    @category = Category.create(name: 'category name', icon: 'category icon', user: @user)
    @valid_attributes = { name: 'purchase_name', amount: 1.0, author: @user,
                          purchase_categories: { category_id: ['', @category.id.to_s] } }
    @invalid_attributes = { name: nil, amount: nil, purchase_categories: { category_id: [] } }
    login_as(@user, scope: :user)
  end

  describe 'GET /index' do
    before(:each) do
      purchase = Purchase.new(@valid_attributes.except(:purchase_categories))
      purchase.categories << @category
      purchase.save!
    end

    it 'renders a successful response with no query params' do
      get purchases_url
      expect(response).to be_successful
    end

    it "renders a successful response with 'category_id' query param" do
      get purchases_url(category_id: @category.id)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response with no query params' do
      get new_purchase_url
      expect(response).to be_successful
    end

    it "renders a successful response with 'category_id' query param" do
      get new_purchase_url
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Purchase' do
        expect do
          post purchases_url, params: { purchase: @valid_attributes }
        end.to change(Purchase, :count).by(1)
      end

      it 'redirects to the created purchase' do
        post purchases_url, params: { purchase: @valid_attributes }
        expect(response).to redirect_to(purchases_url)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Purchase' do
        expect do
          post purchases_url, params: { purchase: @invalid_attributes }
        end.to change(Purchase, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post purchases_url, params: { purchase: @invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
