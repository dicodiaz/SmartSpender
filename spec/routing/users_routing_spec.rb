require 'rails_helper'

RSpec.describe UsersController, type: :routing do
  describe 'routing' do
    it 'routes to #welcome' do
      expect(get: '/welcome').to route_to('users#welcome')
    end
  end
end
