article ||= @article
json.id article['id']
json.call(article, :created_at, :updated_at)
json.title article['title']
json.content article['content']
json.author do
  json.name article.user.username
  json.email_address article.user.email
end
json.comments article.comments, :name, :body, :created_at
