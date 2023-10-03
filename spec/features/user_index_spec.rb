# require 'rails_helper'

# RSpec.describe 'User index', type: :feature do
#   before :each do
#     @user = User.create(name: 'olla', photo: 'https://picsum.photos/id/23/200', bio: 'web developer',
#                         posts_counter: 0)
#     visit root_path
#   end

#   it 'shows the correct content' do
#     expect(page).to have_content('Welcome To User Page')
#   end

#   it 'shows the number of posts each user has written' do
#     expect(page).to have_content('Number of posts')
#   end

#   it 'When I click on a user it should redirect to user/show page' do
#     click_on 'olla'
#     expect(page).to have_content 'olla'
#   end

#   it ' should return the correct css ' do
#     expect(page).to have_css("img[src*='https://picsum.photos/id/23/200']")
#   end
# end
require 'rails_helper'
RSpec.feature 'User Index Page' do
  before(:each) do
    @user1 = create(:user, name: 'user1', photo: 'user1_profile_image.jpg', posts_counter: 0)
    @user2 = create(:user, name: 'user2', photo: 'user2_profile_image.jpg', posts_counter: 1)
  end
  scenario 'I can see the username of all other users' do
    visit users_path
    expect(page).to have_content(@user1.name)
    expect(page).to have_content(@user2.name)
  end
  scenario 'I can see the profile picture for each user' do
    visit users_path
    expect(page).to have_css('img[src*="user1_profile_image.jpg"]')
    expect(page).to have_css('img[src*="user2_profile_image.jpg"]')
  end
  scenario 'I can see the number of posts each user has written' do
    visit users_path
    expect(page).to have_content(@user1.posts_counter)
    expect(page).to have_content(@user2.posts_counter)
  end
  scenario 'When I click on a user, I am redirected to that user\'s show page' do
    visit users_path
    click_link @user1.name
    expect(current_path).to eq(user_path(@user1))
  end
end
