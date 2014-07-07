feature "homepage" do
  scenario "logged out user" do
    visit '/'
    expect(page).to have_content('Contacts')
  end
end