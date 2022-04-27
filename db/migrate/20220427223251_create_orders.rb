class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.references :merchant, foreign_key: true, null: false
      t.references :shopper, foreign_key: true, null: false
      t.decimal :amount, precision: 10, scale: 2
      t.datetime :created_at, null: false
      t.datetime :completed_at, null: true
    end
  end
end
