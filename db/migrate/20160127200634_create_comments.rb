class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.references :post, index: true
      t.datetime :date, :null => false, :default => DateTime.now
      t.references :author, index: true
      t.text :content, :null => false, :default => ''

      t.timestamps
    end
    add_foreign_key :comments, :posts
    add_foreign_key :comments, :users, column: :author_id
  end
end
