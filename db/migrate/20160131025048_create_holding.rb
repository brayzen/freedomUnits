class CreateHolding < ActiveRecord::Migration
  def change
    create_table :holdings do |t|
      t.float :buy_next_unit_at
      t.float :unit_1
      t.datetime :unit_1_date
      t.float :unit_2
      t.datetime :unit_2_date
      t.float :unit_3
      t.datetime :unit_3_date
      t.float :unit_4
      t.datetime :unit_4_date
      t.float :unit_5
      t.datetime :unit_5_date
      t.float :stop_loss
      t.datetime :stop_loss_time
      t.float :atr
    end
  end
end
