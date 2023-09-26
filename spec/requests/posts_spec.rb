require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /users/:id/posts' do
    it 'renders a successful response' do
      get '/users/1/posts'
      expect(response).to be_successful # 3
    end

    it 'renders the index action with index view' do
      get '/users/1/posts'
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
      expect(response).to render_template('posts/index')
      expect(response.body).to include('List of All Posts of a user')
    end

    it 'renders the show action with show view' do
      get '/users/1/posts/1'
      expect(response).to have_http_status(:success)
      expect(response.status).to eq(200)
      expect(response).to render_template('posts/show')
      expect(response.body).to include('show the post by id')
    end
  end
end
