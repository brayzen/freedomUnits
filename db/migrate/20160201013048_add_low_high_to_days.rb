class AddLowHighToDays < ActiveRecord::Migration
  def change
    add_column :days, :low, :float
    add_column :days, :high, :float
  end
end
