class EquityAccount < ActiveRecord::Base
  belongs_to :user
  has_many :holdings
  has_many :kazoos, through :holdings
end
