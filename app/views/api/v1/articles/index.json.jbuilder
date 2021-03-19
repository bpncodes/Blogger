json.articles do
  json.array! @articles do |article|
    json.id article.id
    json.title article.title
    json.comments article.comments, :name, :body, :created_at
  end
end
