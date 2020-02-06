class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :com
      t.boolean :author
      t.references :post, null: false, foreign_key: true

      t.timestamps
    end
  end
end