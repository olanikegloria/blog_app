require 'rails_helper'

RSpec.describe 'User index', type: :feature do
  before :each do
    @user = User.create(name: 'olla', photo: 'https://picsum.photos/id/23/200', bio: 'web developer',
                        posts_counter: 0)
    visit root_path
  end

  it 'shows the correct content' do
    expect(page).to have_content('Welcome To User Page')
  end

  it 'shows the number of posts each user has written' do
    expect(page).to have_content('Number of posts')
  end

  it 'When I click on a user it should redirect to user/show page' do
    click_on 'olla'
    expect(page).to have_content 'olla'
  end

  it ' should return the correct css ' do
    expect(page).to have_css("img[src*='https://picsum.photos/id/23/200']")
  end
end
