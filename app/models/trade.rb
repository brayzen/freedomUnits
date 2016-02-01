class Trade < ActiveRecord::base
  belongs_to :holding
  has_one :kazoo, through :holding
end
