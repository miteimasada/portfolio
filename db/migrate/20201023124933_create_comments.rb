class CreateComments < ActiveRecord::Migration[6.0]
  def change
    drop_table :comments
    create_table :comments do |t|
      t.string :content
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end
