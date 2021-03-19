require 'rails_helper'

feature 'User logs in and logs out' do
  # `js: true` spec metadata means this will run using the `:selenium`
  # browser driver configured in spec/support/capybara.rb
  scenario 'with correct details' do
    create(:user, username: 'bipin')

    visit '/'

    click_link 'Login'
    expect(page).to have_css('a', text: 'Login')
    expect(current_path).to eq(new_user_session_path)

    login 'bipin', 'asdfasdf'



    expect(page).to have_css('h5', text: 'Welcome, bipin')
    expect(current_path).to eq '/'
    expect(page).to have_content 'Signed in successfully'
    expect(page).to have_content 'Hi there, bipin'

    click_link 'Signout'

    expect(current_path).to eq '/'
    expect(page).to have_content 'Signed out successfully'
    expect(page).not_to have_content 'bipin'
  end

  scenario 'incorrect mail or password user cannot login' do
    create(:user)

    visit new_user_session_path

    login 'incorrect', 'test-password'

    expect(current_path).to eq(new_user_session_path)
    expect(page).not_to have_content 'Signed in successfully'
    expect(page).to have_content 'Invalid Username or password.'
  end

  private

  def login(username, password)
    fill_in 'Username', with: username
    fill_in 'Password', with: password
    click_button 'Log in'
  end
end
