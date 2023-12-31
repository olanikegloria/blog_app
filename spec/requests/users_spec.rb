require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /users' do
    it 'renders a successful response' do
      get '/users'
      expect(response).to be_successful
    end

    it 'renders the index action with index view' do
      get '/users'
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
      expect(response.status).not_to eq(404)
      expect(response).to render_template('users/index')
    end
  end
end
