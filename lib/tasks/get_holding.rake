require 'pry'

task :get_holding, [:ticker, :days_back] => :environment do |t, args|
  days_back = args[:days_back] || 150
  ticker = args[:ticker].upcase! || args[:ticker]
  end_date = (Date.today - days_back)
  result = HTTParty.get "https://www.quandl.com/api/v3/datasets/WIKI/#{ticker}.json?start_date=#{end_date}&api_key=#{Rails.application.secrets.quandl_key}"

  keys = result['dataset']['column_names'].map{|key| key.downcase}
  data = result['dataset']['data']
  days = data.map do |day|
    day = Hash[keys.zip(day)]
  end

  kazoo = Kazoo.new days

  if kazoo.watchable?
    p "KAZOO IS WATCHABLE"
  #   puts 'BOOYA!!! it is worthy'
  #   kazoo = Kazoo.find_by ticker_name: ticker
  #   kazoo ||= Kazoo.create! ticker_name: ticker
  #   kazoo.watchable = true
  #   # data2 = data.to_s
  #   # kazoo["data"] = data2 || "can't be NIL"
  #   # kazoo.save

  #   days.each do |day|
  #     kazoo.days.create!(date: day['Date'], close: day['Close'])
  #   end
  #   # Buyable == bought for testing purposes
  #   if Kazoo.buyable?(data)
  #     kazoo.bought = true
  #     kazoo.when_bought = Datetime.now
  #   end
  # else
  #   puts "not worthy!"
  end
end

