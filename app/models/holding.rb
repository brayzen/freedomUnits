class Holding < ActiveRecord::Base
  belongs_to :kazoo
  belongs_to :equity_account
end
