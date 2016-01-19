require 'date'
require 'pry'
require 'rake'

class WelcomeController < ApplicationController
  def index
    # @kazoos = Kazoos.all
  end

  def filter
    @collection.each do |commodity|
      if commodity.close > commodity.sma50 && commodity.sma_cleared
        puts "#{commodity.name} BUY BUY BUY $$$$"
        @buy_list << commodity.name
      end
      if commodity.sma_cleared && commodity.sma50/commodity.close > 0.97
        puts "#{commodity.name} is a potential Cow"
        @radar_watch << commodity.name
      end
      @buy_list << commodity.name
    end
    return [@radar_watch, @buy_list]
  end

  def fetch
    @response = {symbol: "Daily_fetch.new", next_symbol: 'the next one'}
    render json: @response
  end
end
