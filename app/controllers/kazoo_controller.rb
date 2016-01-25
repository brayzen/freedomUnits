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

    render_days = kazoo.recent_days(50).sort_by{|day| day.date}.reverse
    smas = render_days.each_with_index.map{|day, index| [index, day.sma]}
    closes = render_days.each_with_index.map{|day, index| [index, day.close]}
    render json: {days: {smas: smas, closes: closes}}
  end
end
