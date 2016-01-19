class AddTrackingVariablesToKazoo < ActiveRecord::Migration
  def change
    add_column :kazoos, :bought, :boolean
    add_column :kazoos, :watchable, :boolean
    add_column :kazoos, :buyable, :boolean
    add_column :kazoos, :when_bought, :timestamp
  end
end

