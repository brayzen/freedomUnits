class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.datetime :date
      t.float :close
      t.references :kazoo, index: true

      t.timestamps null: false
    end
  end
end
