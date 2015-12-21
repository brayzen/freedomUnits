require 'pry'
# desc "gathering info about a stock"
task :get_holding, [:ticker, :days_back] do |t, args|
  rake db:drop
  args[:days_back] ||= 100

  kazoo = Kazoo.find_by ticker_name: args[:ticker]
  kazoo ||= Kazoo.create! ticker_name: args[:ticker]

  print "Getting #{args[:ticker]} from Quandl"

  result = HTTParty.get "https://www.quandl.com/api/v3/datasets/WIKI/#{args[:ticker]}.json?start_date=#{Date.today - args[:days_back].to_i}"

  keys = result['dataset']['column_names']
  data = result['dataset']['data']

  days = data.map do |day|
    day = Hash[keys.zip(day)]
    kazoo.days.create!({date: day['Date'], close: day['Close']})
  end
end


search_list = ['aapl', 'msft', 'goog', 'amzn', 'wmt']

search_list.each { |holding| :get_holding[holding.upcase!] }
