require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  describe 'for APIs' do
    it 'is a get all articles request -> ok' do
      get(articles_path)
      expect(response).to have_http_status(:ok)
    end

    before(:each) do
      bipin = create(:user)
      bipin.articles.create(title: 'Hello', content: 'Hey')
      post auth_user_path, as: :json, params: { email: 'bipinkarki@gmail.com', password: 'asdfasdf' }
      @resp = JSON.parse(response.body)['auth_token']
    end

    it 'is a get articles api request with authentication -> ok' do
      get api_v1_articles_path, as: :json, headers: { Authorization: @resp }
      expect(response).to have_http_status(:ok)
    end

    it 'is a get articles api request without authentication -> unauthorized' do
      get api_v1_articles_path, as: :json
      expect(response).to have_http_status(:unauthorized)
    end

    it 'is a get article api request with authentication -> ok' do
      get api_v1_articles_path(Article.first), as: :json, params: { id: Article.first.id },
                                               headers: { Authorization: @resp }

      expect(response).to have_http_status(:ok)
    end

    it 'is a get article api request with authentication -> ok' do
      get api_v1_articles_path(Article.first), as: :json, params: { id: Article.first.id },
                                               headers: { Authorization: @resp }

      expect(response).to have_http_status(:ok)
    end

    it 'is a get article api request without authentication -> unauthorized' do
      get api_v1_articles_path(Article.first), as: :json, params: { id: Article.first.id }
      expect(response).to have_http_status(:unauthorized)
    end

    it 'is a post article request with authentication -> created' do
      post api_v1_articles_path, as: :json, params: { title: 'This is title', content: 'This is content' },
                                 headers: { Authorization: @resp }
      expect(response).to have_http_status(:created) # Which means 201
    end

    it 'is a post article request without authentication -> unauthorized' do
      post api_v1_articles_path, as: :json, params: { title: 'This is title', content: 'This is content' }
      expect(response).to have_http_status(:unauthorized)
    end

    it 'is a post article request with empty content -> bad_request' do
      post api_v1_articles_path, as: :json, params: { title: 'This is title' },
                                 headers: { Authorization: @resp }
      expect(response).to have_http_status(:bad_request)
    end

    it 'is a delete article request with correct id with correct authentication -> ok' do
      delete api_v1_article_path(Article.first), as: :json,
                                                 headers: { Authorization: @resp }
      expect(response).to have_http_status(:ok)
    end

    it 'is a delete article request with incorrect id with correct authentication -> not_found' do
      delete api_v1_article_path(2), as: :json,
                                     headers: { Authorization: @resp }
      expect(response).to have_http_status(:not_found)
    end

    it 'is a delete article request without authentication -> unauthorized' do
      delete api_v1_article_path(Article.first), as: :json
      expect(response).to have_http_status(:unauthorized)
    end

    it 'is a patch article request with correct id with correct authentication -> ok' do
      patch api_v1_article_path(Article.first), as: :json, params: { title: 'Updated' },
                                                headers: { Authorization: @resp }
      expect(response).to have_http_status(:ok)
    end

    it 'is a patch article request with correct id with correct authentication -> unauthorized' do
      patch api_v1_article_path(Article.first), as: :json, params: { title: 'Updated' }
      expect(response).to have_http_status(:unauthorized)
    end

    it 'is a patch article request with incorrect id with correct authentication -> not found' do
      patch api_v1_article_path(2), as: :json, params: { title: 'Updated' },
                                    headers: { Authorization: @resp }
      expect(response).to have_http_status(:not_found)
    end
  end
end
