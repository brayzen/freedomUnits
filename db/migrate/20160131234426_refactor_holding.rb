class RefactorHolding < ActiveRecord::Migration
  def change
    remove_column :holdings, :buy_next_unit_at, :float
    remove_column :holdings, :stop_loss_time, :float
    remove_column :holdings, :atr, :float
    remove_column :holdings, :unit_1, :float
    remove_column :holdings, :unit_2, :float
    remove_column :holdings, :unit_3, :float
    remove_column :holdings, :unit_4, :float
    remove_column :holdings, :unit_5, :float
    remove_column :holdings, :unit_1_date, :float
    remove_column :holdings, :unit_2_date, :float
    remove_column :holdings, :unit_3_date, :float
    remove_column :holdings, :unit_4_date, :float
    remove_column :holdings, :unit_5_date, :float
    change_table :holdings do |t|
      t.float :profit_loss
      t.integer :units
      t.float :buy_point
    end
  end
end
