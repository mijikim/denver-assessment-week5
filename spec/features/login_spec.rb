feature "log in" do
  scenario "logged out user" do
    visit '/login'
    fill_in 'username', with: 'Jeff'
    fill_in 'password', with: 'jeff123'
    click_button('Log In')
  end
end