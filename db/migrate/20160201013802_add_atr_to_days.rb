class AddAtrToDays < ActiveRecord::Migration
  def change
    add_column :days, :atr, :float
  end
end
