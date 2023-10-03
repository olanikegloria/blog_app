# require 'rails_helper'
# RSpec.describe 'Post index ' do
#   before :each do
#     @user = User.create(name: 'olla', photo: 'https://picsum.photos/id/23/200', bio: 'web developer',
#                         posts_counter: 0)
#     @post1 = Post.create(author_id: @user.id, title: 'Hello Rails', text: 'first post', likes_counter: 0,
#                          comments_counter: 0)
#     @post2 = Post.create(author_id: @user.id, title: 'Hello World', text: 'second post', likes_counter: 0,
#                          comments_counter: 0)
#     @post3 = Post.create(author_id: @user.id, title: 'Hello Ruby', text: 'third post', likes_counter: 0,
#                          comments_counter: 0)
#     @comment = Comment.create(user_id: @user.id, post_id: @post1.id, text: 'first comment')
#     visit user_posts_path(@user.id)
#   end
#   it 'see the user profile picture' do
#     expect(page).to have_css("img[src*='https://picsum.photos/id/23/200']")
#   end
#   it ' can see the user name' do
#     expect(page).to have_content('olla')
#   end
#   it 'can see the number of posts user has written' do
#     expect(page).to have_content('Number of posts: 3')
#   end
#   it 'can see a post title' do
#     expect(page).to have_content('Hello Rails')
#   end
#   it 'can see some of post body' do
#     expect(page).to have_content('first post')
#   end
#   it 'can see first comment on post ' do
#     expect(page).to have_content('first comment')
#   end
#   it 'can see how many comment has' do
#     expect(page).to have_content('Comments 1')
#   end
#   it ' can see how many likes a post has ' do
#     expect(page).to have_content('Likes 0')
#   end
#   it 'can see section for pagination  if there are more posts than fit on the view. ' do
#     expect(page).to have_content('Pagination')
#   end
#   it "When I click on a post, it redirects me to that post's show page." do
#     click_on 'Hello Rails'
#     expect(page).to have_content('Hello Rails')
#   end
# end

# rubocop:disable Metrics/BlockLength
require 'rails_helper'
RSpec.feature 'Post Index Page' do
  before(:each) do
    @user2 = create(:user)
    @user1 = create(:user, name: 'user1', bio: 'Teacher from Uganda', photo: 'user1_profile_image.jpg',
                           posts_counter: 0)
    @post1 = create(:post, author_id: @user1.id, title: 'Hello')
    @post2 = create(:post, author_id: @user1.id, title: 'World', text: 'Hi men', comments_counter: 1, likes_counter: 2)
    @comment = create(:comment, post_id: @post2.id, user_id: @user2.id, text: 'a comment')
  end
  scenario 'I can see the username of the user' do
    visit user_posts_path(@user1)
    expect(page).to have_content(@user1.name)
  end
  scenario 'I can see the profile picture for each user' do
    visit user_posts_path(@user1)
    expect(page).to have_css('img[src*="user1_profile_image.jpg"]')
  end
  scenario 'I can see the number of posts of the user' do
    visit user_posts_path(@user1)
    expect(page).to have_content(@user1.posts_counter)
  end
  scenario 'I can a posts title' do
    visit user_posts_path(@user1)
    expect(page).to have_content(@post2.title)
  end
  scenario 'I can some of the post body' do
    visit user_posts_path(@user1)
    expect(page).to have_content(@post2.text)
  end
  scenario 'I can see the comments on a post' do
    visit user_posts_path(@user1)
    expect(page).to have_content(@comment.text)
  end
  scenario 'I can see the number of comments on a post' do
    visit user_posts_path(@user1)
    expect(page).to have_content(@post2.comments_counter)
  end
  scenario 'I can see the number of likes a post has' do
    visit user_posts_path(@user1)
    expect(page).to have_content(@post2.likes_counter)
  end
  scenario 'When I click a user\'s post, it redirects me to that post\'s show page' do
    visit user_path(@user1)
    expect(page).to have_link(@post2.title)
    click_link @post2.title
    expect(current_path).to eq(user_post_path(@user1, @post2))
  end
end
# rubocop:enable Metrics/BlockLength
