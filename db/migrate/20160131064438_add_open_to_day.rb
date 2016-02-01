class AddOpenToDay < ActiveRecord::Migration
  def change
    add_column :days, :open, :float
  end
end
