require 'date'

class GraphController < ApplicationController

  def index
    @data = params[:symbol] ? compile_graph_data : "Hit submit"
  end

  def find_SMA(data, start_date, end_date)
    collection = data["dataset_data"]["data"].slice(start_date.to_i, end_date.to_i).map{ |day| day[4] }
    collection.reduce{ |memo, cur| memo + cur } / collection.length
  end

  def sma_generator(data)
    start_date = 0
    end_date = 50
    array_of_smas = []
    50.times do
      array_of_smas << find_SMA(data, start_date, end_date)
      start_date += 1
      end_date += 1
    end
    return array_of_smas.reverse.each_with_index.map{ |x, i| [i, x]}
  end

  def find_last_50_prices(data)
    days = data["dataset_data"]["data"]
    days.slice(0, 50).reverse.each_with_index.map{ |day, i| [i, day[4]] }
  end

  def strt_date
    (Date.today - 100).to_s
  end

  def compile_graph_data
    @graph_data = {}
    symbol = params[:symbol]
    puts "HTTParty.get('https://www.quandl.com/api/v3/datasets/WIKI/#{symbol}/data.json?start_date=#{strt_date}')"
    data = HTTParty.get("https://www.quandl.com/api/v3/datasets/WIKI/#{symbol}/data.json?start_date=#{strt_date}")
    logger.info data
    if data["quandl_error"] || !data
      flash[:error] = "API call failed"
    else
      @graph_data[:sma50] = sma_generator(data)
      @graph_data[:price] = find_last_50_prices(data)
      respond_to do |format|
        format.html { @graph_data }
        format.js { render :json => @graph_data }
        format.json { render :json => @graph_data }
      end
    end
  end
end
