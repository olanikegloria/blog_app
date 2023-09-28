class RenameColumnsInLikesAndCommentsClasses < ActiveRecord::Migration[7.0]
  def up
    remove_reference :likes, :author, foreign_key: { to_table: :users }
    add_reference :likes, :user, foreign_key: true, index: true, null: false
    remove_reference :comments, :author, foreign_key: { to_table: :users }
    add_reference :comments, :user, foreign_key: true, index: true, null: false
  end

  def down
    add_reference :likes, :author, foreign_key: { to_table: :users }
    add_reference :comments, :author, foreign_key: { to_table: :users }
  end
end
