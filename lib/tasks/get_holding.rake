require 'pry'

task :get_holding, [:ticker, :days_back] => :environment do |t, args|
  days_back = args[:days_back] || 150
  ticker = args[:ticker].upcase! || args[:ticker]

  end_date = (Date.today - days_back)

  print "Getting #{ticker} from Quandl"
  puts "https://www.quandl.com/api/v3/datasets/WIKI/#{ticker}.json?start_date=#{end_date}"
  result = HTTParty.get "https://www.quandl.com/api/v3/datasets/WIKI/#{ticker}.json?start_date=#{end_date}&api_key=#{Rails.application.secrets.quandl_key}"

  keys = result['dataset']['column_names']
  data = result['dataset']['data']

  if Kazoo.watchable?(data)

    puts 'YAHOO!!! is worthy'
    kazoo = Kazoo.find_by ticker_name: ticker
    kazoo ||= Kazoo.create! ticker_name: ticker
    kazoo.watchable = true
    # data2 = data.to_s
    # kazoo["data"] = data2 || "can't be NIL"
    # kazoo.save
    days = data.map do |day|
      day = Hash[keys.zip(day)]
      kazoo.days.create!(date: day['Date'], close: day['Close'])
    end
    # Buyable == bought for testing purposes
    if Kazoo.buyable(data)
      kazoo.bought = true
      kazoo.when_bought = Datetime.now
    end
  end
end

