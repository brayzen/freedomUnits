class AddKazooIdToHoldings < ActiveRecord::Migration
  def change
    add_reference :holdings, :kazoo, index: true
  end
end
