require 'pry'

task :get_holding, [:ticker, :days_back] => :environment do |t, args|
  days_back = args[:days_back] || 150
  ticker = args[:ticker].upcase!.chomp || args[:ticker].chomp

  end_date = (Date.today - days_back)

  print "Getting #{ticker} from Quandl"
  puts "https://www.quandl.com/api/v3/datasets/WIKI/#{ticker}.json?start_date=#{end_date}"
  result = HTTParty.get "https://www.quandl.com/api/v3/datasets/WIKI/#{ticker}.json?start_date=#{end_date}&api_key=#{Rails.application.secrets.quandl_key}"

  kazoo = Kazoo.find_by ticker_name: ticker
  kazoo ||= Kazoo.create! ticker_name: ticker
  keys = result['dataset']['column_names']
  data = result['dataset']['data']
  data2 = data.to_s
  kazoo["data"] = data2 || "can't be NIL"
  kazoo.save

  count = 1
  days = data.map do |day|
    day = Hash[keys.zip(day)]
    kazoo.days.create!(date: day['Date'], close: day['Close'])
  end
end

