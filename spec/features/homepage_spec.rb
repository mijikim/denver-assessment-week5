feature "homepage" do
  scenario "logged out user" do
    visit '/'
    expect(page).to have_content('Contacts')
    click_link('Log In')
  end
end