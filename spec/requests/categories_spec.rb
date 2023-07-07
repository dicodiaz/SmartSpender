require 'rails_helper'

RSpec.describe '/categories', type: :request do
  before(:each) do
    @user = User.create(name: 'user name', email: 'user_email@mail.com', password: 'user_password')
    @valid_attributes = { name: 'category name', icon: 'category icon', user: @user }
    @invalid_attributes = { name: nil, icon: nil }
    login_as(@user, scope: :user)
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Category.create! @valid_attributes
      get categories_url
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_category_url
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Category' do
        expect do
          post categories_url, params: { category: @valid_attributes }
        end.to change(Category, :count).by(1)
      end

      it 'redirects to the created category' do
        post categories_url, params: { category: @valid_attributes }
        expect(response).to redirect_to(categories_url)
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Category' do
        expect do
          post categories_url, params: { category: @invalid_attributes }
        end.to change(Category, :count).by(0)
      end

      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post categories_url, params: { category: @invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
