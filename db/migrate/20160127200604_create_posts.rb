class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.references :author, index: true
      t.datetime :date
      t.string :title
      t.text :content

      t.timestamps
    end
    add_foreign_key :posts, :users, column: :author_id
  end
end
