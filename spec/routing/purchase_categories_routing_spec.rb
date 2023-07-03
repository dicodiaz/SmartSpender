require 'rails_helper'

RSpec.describe PurchaseCategoriesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/purchase_categories').to route_to('purchase_categories#index')
    end

    it 'routes to #new' do
      expect(get: '/purchase_categories/new').to route_to('purchase_categories#new')
    end

    it 'routes to #show' do
      expect(get: '/purchase_categories/1').to route_to('purchase_categories#show', id: '1')
    end

    it 'routes to #edit' do
      expect(get: '/purchase_categories/1/edit').to route_to('purchase_categories#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/purchase_categories').to route_to('purchase_categories#create')
    end

    it 'routes to #update via PUT' do
      expect(put: '/purchase_categories/1').to route_to('purchase_categories#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: '/purchase_categories/1').to route_to('purchase_categories#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: '/purchase_categories/1').to route_to('purchase_categories#destroy', id: '1')
    end
  end
end
