class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def comment_counter_updates
    post.update(comments_counter: post.comments.count)
  end

  after_create :comment_counter_updates
  after_destroy :comment_counter_updates
end
