require 'rails_helper'

RSpec.describe "Users", type: :request do
    before(:each) do
      bipin = create(:user)
      bipin.articles.create(title: 'Hello', content: 'Hey')
    end
  describe "GET /index" do
    # it 'returns a success response' do
    #   post user_session_path, params: { email: 'bipinkarki@gmail.com', password: 'asdfasdf' }

    #   expect(response).to redirect_to(articles_path)
    # end
    # it 'returns a unsuccessful response' do
    #   post user_session_path, params: { email: 'bipinkarki@gmail.com', password: 'kas' }
    #   expect(response).to have_http_status(:unauthorized)
    # end
  end
end
