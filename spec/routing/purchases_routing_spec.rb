require 'rails_helper'

RSpec.describe PurchasesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/purchases').to route_to('purchases#index')
    end

    it 'routes to #new' do
      expect(get: '/purchases/new').to route_to('purchases#new')
    end

    it 'routes to #create' do
      expect(post: '/purchases').to route_to('purchases#create')
    end
  end
end
