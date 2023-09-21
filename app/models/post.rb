class Post < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :comments, foreign_key: :post_id
  has_many :likes, foreign_key: :post_id

  after_save :post_counter_updates

  private

  def post_counter_updates
    author.increment!(:posts_counter)
  end

  def latest_comments
    comments.order(created_at: :desc).limit(5)
  end
end
