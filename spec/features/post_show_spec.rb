# require 'rails_helper'

# RSpec.describe 'Post show' do
#   before :each do
#     @user = User.create(name: 'Htet', photo: 'https://picsum.photos/id/23/200', bio: 'web developer',
#                         posts_counter: 0)
#     @post1 = Post.create(author_id: @user.id, title: 'Hello Rails', text: 'first post', likes_counter: 0,
#                          comments_counter: 0)
#     @post2 = Post.create(author_id: @user.id, title: 'Hello World', text: 'second post', likes_counter: 0,
#                          comments_counter: 0)
#     @post3 = Post.create(author_id: @user.id, title: 'Hello Ruby', text: 'third post', likes_counter: 0,
#                          comments_counter: 0)
#     @comment1 = Comment.create(user_id: @user.id, post_id: @post1.id, text: 'first comment')
#     @comment2 = Comment.create(user_id: @user.id, post_id: @post1.id, text: 'second comment')
#     @like = Like.create(user_id: @user.id, post_id: @post1.id)
#     visit user_post_path(@user.id, @post1.id)
#   end

#   it 'see the post title' do
#     expect(page).to have_content('Hello Rails')
#   end

#   it 'see who wrote the post' do
#     expect(page).to have_content('Htet')
#   end

#   it 'see how many comments it has' do
#     expect(page).to have_content('Comments: 2')
#   end

#   it 'see how many likes it has' do
#     expect(page).to have_content('Likes: 1')
#   end

#   it 'see the post body' do
#     expect(page).to have_content('first post')
#   end

#   it 'see the username of each commentor' do
#     expect(page).to have_content(@comment1.author.name)
#     expect(page).to have_content(@comment2.author.name)
#   end

#   it 'see the comment of each commentor left' do
#     expect(page).to have_content(@comment1.text)
#     expect(page).to have_content(@comment2.text)
#   end
# end
# rubocop:disable Metrics/BlockLength
require 'rails_helper'
RSpec.feature 'Post Show Page' do
  before(:each) do
    @user1 = create(:user, name: 'user1', bio: 'Teacher from Uganda', photo: 'user1_profile_image.jpg',
                           posts_counter: 0)
    @user2 = create(:user, name: 'User2')
    @post = create(:post, author_id: @user1.id, title: 'Hello', comments_counter: 2, likes_counter: 1,
                          text: 'Post body')
    @comment = create(:comment, user_id: @user2.id, post_id: @post.id, text: 'my comment')
  end
  scenario 'I can see the title of the post' do
    visit user_post_path(@user1, @post)
    expect(page).to have_content(@post.title)
  end
  scenario 'I can see the number of comments of the post' do
    visit user_post_path(@user1, @post)
    expect(page).to have_content(@post.comments_counter)
  end
  scenario 'I can see the number of likes of the post' do
    visit user_post_path(@user1, @post)
    expect(page).to have_content(@post.likes_counter)
  end
  scenario 'I can see the body of the post' do
    visit user_post_path(@user1, @post)
    expect(page).to have_content(@post.text)
  end
  scenario 'I can see the username of each commenter' do
    visit user_post_path(@user1, @post)
    expect(page).to have_content(@user2.name)
  end
  scenario 'I can see the comment of each commenter' do
    visit user_post_path(@user1, @post)
    expect(page).to have_content(@comment.text)
  end
end
# rubocop:enable Metrics/BlockLength
