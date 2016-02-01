class CreateTrade < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.boolean :buy
      t.float :price
      t.integer :quantity
      t.float :dollars
    end
  end
end
