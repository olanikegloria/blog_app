# require 'rails_helper'

# RSpec.describe 'User show', type: :feature do
#   before :each do
#     @user = User.create(name: 'olla', photo: 'https://picsum.photos/id/23/200', bio: 'web developer',
#                         posts_counter: 0)
#     @post1 = Post.create(author_id: @user.id, title: 'Hello Rails', text: 'first post', likes_counter: 0,
#                          comments_counter: 0)
#     @post2 = Post.create(author_id: @user.id, title: 'Hello World', text: 'second post', likes_counter: 0,
#                          comments_counter: 0)
#     @post3 = Post.create(author_id: @user.id, title: 'Hello Ruby', text: 'third post', likes_counter: 0,
#                          comments_counter: 0)
#     visit user_path(@user.id)
#   end

#   it 'see the user profile picture' do
#     expect(page).to have_css("img[src*='https://picsum.photos/id/23/200']")
#   end

#   it 'see the user profile name' do
#     expect(page).to have_content 'olla'
#   end

#   it 'see the number of posts user has written' do
#     expect(page).to have_content 'Number of posts: 3'
#   end

#   it 'see the user bio ' do
#     expect(page).to have_content 'web developer'
#   end

#   it 'see the user first three posts ' do
#     expect(page).to have_content('first post')
#     expect(page).to have_content('second post')
#     expect(page).to have_content('third post')
#   end

#   it 'see the button that let me view all users posts' do
#     expect(page).to have_link('See all posts')
#   end

#   it "When I click a user's post, it redirects me to that post's show page." do
#     click_on 'Hello Rails'
#     expect(page).to have_content 'first post'
#   end

#   it " When I click to see all posts, it redirects me to the user's post's index page. " do
#     click_on 'See all posts'
#     expect(page).to have_content "olla's Posts"
#   end
# end

# rubocop:disable Metrics/BlockLength
require 'rails_helper'
RSpec.feature 'User Show Page' do
  before(:each) do
    @user1 = create(:user, name: 'user1', bio: 'Teacher from Uganda', photo: 'user1_profile_image.jpg',
                           posts_counter: 0)
    @post1 = create(:post, author_id: @user1.id, title: 'Madagascar is Bae')
    @post2 = create(:post, author_id: @user1.id, title: 'World of authentic vibes')
    @post3 = create(:post, author_id: @user1.id, title: 'Arcing retremony')
    @post4 = create(:post, author_id: @user1.id, title: 'Joe of the guitar')
  end
  scenario 'I can see the username of the user' do
    visit user_path(@user1)
    expect(page).to have_content(@user1.name)
  end
  scenario 'I can see the profile picture for each user' do
    visit user_path(@user1)
    expect(page).to have_css('img[src*="user1_profile_image.jpg"]')
  end
  scenario 'I can see the number of posts of the user' do
    visit user_path(@user1)
    expect(page).to have_content(@user1.posts_counter)
  end
  scenario 'I can see the bio of the user' do
    visit user_path(@user1)
    expect(page).to have_content(@user1.bio)
  end
  scenario 'I can see a button to view user\'s posts' do
    visit user_path(@user1)
    expect(page).to have_content('See all posts')
  end
  scenario 'I can see the last 3 posts of the user' do
    visit user_path(@user1)
    expect(page).to have_text(@post4.title, wait: 10)
    expect(page).to have_text(@post2.title, wait: 10)
    expect(page).to have_text(@post3.title, wait: 10)
  end
  scenario 'When I click a user\'s post, it redirects me to that post\'s show page' do
    visit user_path(@user1)
    expect(page).to have_link(@post2.title)
    click_link @post2.title
    expect(current_path).to eq(user_post_path(@user1, @post2))
  end
  scenario 'When I click to see all posts, it redirects me to the user\'s post\'s index page' do
    visit user_path(@user1)
    click_link 'See all posts'
    expect(current_path).to eq(user_posts_path(@user1))
  end
end
# rubocop:enable Metrics/BlockLength
