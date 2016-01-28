class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.references :post, index: true
      t.string :name, :null => false, :default => ''

      t.timestamps
    end
    add_foreign_key :tags, :posts
  end
end
