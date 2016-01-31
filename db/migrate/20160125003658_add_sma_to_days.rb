class AddSmaToDays < ActiveRecord::Migration
  def change
    add_column :days, :sma, :float
  end
end
