class CreateKazoo < ActiveRecord::Migration
  def change
    create_table :kazoos do |t|
      t.string :ticker_name

      t.timestamps null: false
    end
  end
end
