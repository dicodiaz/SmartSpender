require 'rails_helper'

RSpec.describe '/users', type: :request do
  describe 'GET /welcome' do
    it 'renders a successful response' do
      get welcome_url
      expect(response).to be_successful
    end
  end
end
