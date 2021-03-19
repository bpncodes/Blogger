require 'rails_helper'

RSpec.describe Article, type: :model do
  context 'article model create tests' do
    it 'ensures title is given' do
      article = Article.new(content: 'Hello', user_id: 1).save
      expect(article).to eq(false)
    end
    it 'ensures body is present' do
      article = Article.new(title: 'Hello', user_id: 1).save
      expect(article).to eq(false)
    end
    it 'ensure user id  present' do
      article = Article.new(title: 'Hello', content: 'Hey').save
      expect(article).to eq(false)
    end
    it 'create article success' do
      bipin = User.create(username: 'Bipin_Karki', password: 'asdfasdf', role: 'normal_user',
                          email: 'bipinkarki@gmail.com')
      articles = bipin.articles.new(title: 'Hello', content: 'Hey').save
      expect(articles).to eq(true)
    end
  end

  context 'articles  model update test' do
    it 'article updates with only title' do
      bipin = User.create(username: 'Bipin_Karki', password: 'asdfasdf', role: 'normal_user',
                          email: 'bipinkarki@gmail.com')
      article = bipin.articles.create(title: 'Hello', content: 'Hey')
      status = article.update_attribute(:title,'hello')
      expect(status).to eq(true)
    end
    it 'article updates with only content' do
      bipin = User.create(username: 'Bipin_Karki', password: 'asdfasdf', role: 'normal_user',
                          email: 'bipinkarki@gmail.com')
      article = bipin.articles.create(title: 'Hello', content: 'Hey')
      status = article.update_attribute(:content,'hello')
      expect(status).to eq(true)
    end
  end

  context 'articles model method test' do
    let(:params) { { title: 'Hello', content: 'Hey' } }
    before(:each) do
      bipin = User.create(username: 'Bipin_Karki', password: 'asdfasdf', role: 'normal_user',
                          email: 'bipinkarki@gmail.com')
      bipin.articles.new(params).save
      bipin.articles.new(params).save
      bipin.articles.new(params).save
      bipin.articles.new(params).save
    end
    it 'model method number of articles tests' do
      expect(User.first.articles.size).to eql(4)
    end
  end
end
