class Comment < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  belongs_to :post

  after_save :comment_counter_updates

  def comment_counter_updates
    post.increment!(:comments_counter)
  end
end
