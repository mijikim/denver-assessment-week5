feature "log in" do
  scenario "view log in form" do
    visit '/'
    click_link('Log In')
    find_field('username')
    find_field('password')
    find_button('Log In')
  end

  scenario "logged out user" do
    visit '/login'
    fill_in 'username', with: 'Jeff'
    fill_in 'password', with: 'jeff123'
    click_button('Log In')
    expect(page).to have_content("Welcome Jeff")
    expect(page).to have_content("Spencer")
  end
end