require 'pry'
# desc "gathering info about a stock"
task :get_stock, [:ticker, :days_back] => :environment do |t, args|
  args[:days_back] ||= 100

  kazoo = Kazoo.find_by ticker_name: args[:ticker]
  kazoo ||= Kazoo.create! ticker_name: args[:ticker]

  print "Getting #{args[:ticker]} from Quandl"

  result = HTTParty.get "https://www.quandl.com/api/v3/datasets/WIKI/#{args[:ticker]}.json?start_date=#{Date.today - args[:days_back].to_i}"

  keys = result['dataset']['column_names']
  data = result['dataset']['data']

  days = data.map do |day|
    Hash[day.map.with_index do |datum, index|
      [keys[index], datum]
    end]
  end

  # binding.pry
  days.each do |day|
    kazoo.days.create!({date: day['Date'], close: day['Close']})
  end
end


