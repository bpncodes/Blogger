Given('I create user as name {string} with password {string}') do |name, password|
   @user = User.create!(username: name, password: password,role: "admin")
end

Then('I create article by title {string} with content {string}') do |title, content|
   @user.articles.create!(title: title, content: content)
end

Then('I login as {string} and password {string}') do |name, password|
   visit new_user_session_path
   fill_in('user_username', with:name)
   fill_in('user_password', with:password)
   click_on "Log in"
end

Then('I login with name {string} and password {string}') do |name, password|
   fill_in('user_username', with:name)
   fill_in('user_password', with:password)
end