class AddTrackingVariablesToKazoo < ActiveRecord::Migration
  def change
    add_column :kazoos, :watchable, :boolean
    add_column :kazoos, :buyable, :boolean
  end
end

