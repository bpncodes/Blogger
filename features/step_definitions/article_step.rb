When('I am on all articles path') do
  visit articles_path
end

Then('I should see {string}') do |title|
  page.should have_content(title)
end

When('I press {string}') do |string|
    click_on string
end

Then('I create a comment with name {string} and body {string}') do |name, body|
   fill_in('comment_name', with:name)
   fill_in('comment_body', with:body)
end