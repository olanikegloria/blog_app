require 'rails_helper'
RSpec.describe 'Post index ' do
  before :each do
    @user = User.create(name: 'olla', photo: 'https://picsum.photos/id/23/200', bio: 'web developer',
                        posts_counter: 0)
    @post1 = Post.create(author_id: @user.id, title: 'Hello Rails', text: 'first post', likes_counter: 0,
                         comments_counter: 0)
    @post2 = Post.create(author_id: @user.id, title: 'Hello World', text: 'second post', likes_counter: 0,
                         comments_counter: 0)
    @post3 = Post.create(author_id: @user.id, title: 'Hello Ruby', text: 'third post', likes_counter: 0,
                         comments_counter: 0)
    @comment = Comment.create(user_id: @user.id, post_id: @post1.id, text: 'first comment')
    visit user_posts_path(@user.id)
  end
  it 'see the user profile picture' do
    expect(page).to have_css("img[src*='https://picsum.photos/id/23/200']")
  end
  it ' can see the user name' do
    expect(page).to have_content('olla')
  end
  it 'can see the number of posts user has written' do
    expect(page).to have_content('Number of posts: 3')
  end
  it 'can see a post title' do
    expect(page).to have_content('Hello Rails')
  end
  it 'can see some of post body' do
    expect(page).to have_content('first post')
  end
  it 'can see first comment on post ' do
    expect(page).to have_content('first comment')
  end
  it 'can see how many comment has' do
    expect(page).to have_content('Comments 1')
  end
  it ' can see how many likes a post has ' do
    expect(page).to have_content('Likes 0')
  end
  it 'can see section for pagination  if there are more posts than fit on the view. ' do
    expect(page).to have_content('Pagination')
  end
  it "When I click on a post, it redirects me to that post's show page." do
    click_on 'Hello Rails'
    expect(page).to have_content('Hello Rails')
  end
end
