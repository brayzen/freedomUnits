class AddRiskLevelToEquityAccount < ActiveRecord::Migration
  def change
    add_column :equity_accounts, :risk, :integer
  end
end
