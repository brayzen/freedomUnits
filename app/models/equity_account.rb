class EquityAccount < ActiveRecord::Base
  belongs_to :user
  has_many :holdings
end
