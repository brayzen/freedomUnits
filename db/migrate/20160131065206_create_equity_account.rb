class CreateEquityAccount < ActiveRecord::Migration
  def change
    create_table :equity_accounts do |t|
      t.float :total_equity
      t.float :core_equity
      t.float :profit_loss
    end
  end
end
