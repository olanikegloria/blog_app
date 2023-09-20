class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.references :user, foriegn_key: true
      t.references :post, foriegn_key: true
      t.string :text
      
      t.timestamps
    end
  end
end
