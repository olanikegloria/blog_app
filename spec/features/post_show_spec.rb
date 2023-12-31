require 'rails_helper'

RSpec.describe 'Post Show Page', type: :feature do
  describe 'Viewing post show page' do
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
end
