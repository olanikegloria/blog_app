class Like < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  belongs_to :post

  after_save :likes_counter_updates

  def likes_counter_updates
    post.increment!(:likes_counter)
  end
end
