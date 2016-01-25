require 'date'
require 'pry'
require 'rake'

class KazooController < ApplicationController
  def index
  end

  def show
    fetch_data
  end

  def fetch_data
    symbol = params[:symbol]
    start_date = DateTime.now - 100.days
    result = HTTParty.get "https://www.quandl.com/api/v3/datasets/WIKI/#{symbol}.json?start_date=#{start_date}"
    keys = result['dataset']['column_names'].map{|key| key.downcase}
    data = result['dataset']['data']
    days = data.map do |day|
      Hash[keys.zip(day)]
    end
    kazoo = Kazoo.create
    kazoo.create_days days

    render json: kaz
  end

  # def compile_graph_data
  #   @graph_data = {}
  #   symbol = params[:symbol]
  #   data = HTTParty.get("https://www.quandl.com/api/v3/datasets/WIKI/#{symbol}/data.json?start_date=#{strt_date}&api_key=#{Rails.application.secrets.quandl_key}")
  #   if data["quandl_error"] || !data
  #     flash[:error] = "API call failed"
  #   else
  #     @graph_data[:sma50] = sma_generator(data)
  #     @graph_data[:price] = find_last_50_prices(data)
  #     respond_to do |format|
  #       format.html { @graph_data }
  #       format.js { render :json => @graph_data }
  #       format.json { render :json => @graph_data }
  #     end
  #   end
  # end
end
