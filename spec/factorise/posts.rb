FactoryBot.define do
  factory :post do
    title { 'Sample Title' }
    text { 'This is a sample post.' }
    comments_counter { 0 }
    likes_counter { 0 }
    association :author_id, factory: :user
  end
end
