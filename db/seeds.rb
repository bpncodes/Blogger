# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
names = %w[Brad John Jade Bipin Potter]
User.create(username: 'admin', password: 'asdfasdf', role: 'admin',email:'bipinninza23@yahoo.com')
User.create(username: 'editor', password: 'asdfasdf', role: 'editor',email:'bipinkarki20@yahoo.com')
User.create(username: 'Bipin_Karki', password: 'asdfasdf', role: 'normal_user',email:'bipinkarki@gmail.com')

3.times do |i|
  Article.create!({ title: "The future of technology",
                    content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", user_id: 1 })
  id = i + 1
  3.times do |j|
    Comment.create!({ name: names[rand(5)].to_s, body: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters", user_id: 1,
                      article_id: id })
  end
end

3.times do |i|
  Article.create!({ title: "The Tortoise and the hare",
                    content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", user_id: 2 })
  id = i + 4
  3.times do |j|
    Comment.create!({ name: names[rand(5)].to_s, body: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters",
                      user_id: 2, article_id: id })
  end
end

3.times do |i|
  Article.create!({ title: "How and why we write code",
                    content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.", user_id: 3 })
  id = i + 7
  3.times do |j|
    Comment.create!({ name: names[rand(5)].to_s, body: "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters", user_id: 3,
                      article_id: id })
  end
end
