feature 'signing up' do
  before do
    visit('/')
    click_button('sign up')
    fill_in(:email, with: 'test@test.com')
    fill_in(:password, with: 'secrettest')
    # click_button('submit')
  end
  scenario 'when a user signs up the user count increased by 1' do
    expect { click_button('submit') }.to change(User, :count).by(1)

  end
  scenario 'page displays a welcome message' do
    click_button('submit')
    expect(page).to have_content('Welcome, please begin adding bookmarks')
  end
  scenario 'database stores email' do
    click_button('submit')
    expect(User.all.map(&:email)).to include('test@test.com')
  end
end
