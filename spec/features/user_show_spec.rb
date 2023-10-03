require 'rails_helper'

RSpec.describe 'User show', type: :feature do
  before :each do
    @user = User.create(name: 'olla', photo: 'https://picsum.photos/id/23/200', bio: 'web developer',
                        posts_counter: 0)
    @post1 = Post.create(author_id: @user.id, title: 'Hello Rails', text: 'first post', likes_counter: 0,
                         comments_counter: 0)
    @post2 = Post.create(author_id: @user.id, title: 'Hello World', text: 'second post', likes_counter: 0,
                         comments_counter: 0)
    @post3 = Post.create(author_id: @user.id, title: 'Hello Ruby', text: 'third post', likes_counter: 0,
                         comments_counter: 0)
    visit user_path(@user.id)
  end

  it 'see the user profile picture' do
    expect(page).to have_css("img[src*='https://picsum.photos/id/23/200']")
  end

  it 'see the user profile name' do
    expect(page).to have_content 'olla'
  end

  it 'see the number of posts user has written' do
    expect(page).to have_content 'Number of posts: 3'
  end

  it 'see the user bio ' do
    expect(page).to have_content 'web developer'
  end

  it 'see the user first three posts ' do
    expect(page).to have_content('first post')
    expect(page).to have_content('second post')
    expect(page).to have_content('third post')
  end

  it 'see the button that let me view all users posts' do
    expect(page).to have_link('See all posts')
  end

  it "When I click a user's post, it redirects me to that post's show page." do
    click_on 'Hello Rails'
    expect(page).to have_content 'first post'
  end

  it " When I click to see all posts, it redirects me to the user's post's index page. " do
    click_on 'See all posts'
    expect(page).to have_content "olla's Posts"
  end
end
