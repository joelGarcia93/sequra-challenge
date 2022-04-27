class CreateShoppers < ActiveRecord::Migration[5.2]
  def change
    create_table :shoppers do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :nif, null: false
      t.index :email, unique: true
    end
  end
end
