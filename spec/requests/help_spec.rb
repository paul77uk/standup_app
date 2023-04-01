require 'rails_helper'

RSpec.describe 'Helps', type: :request do
  login_user

  describe 'GET /index' do
    it 'returns http success' do
      get '/help/'
      expect(response).to have_http_status(:success)
    end
  end
end
