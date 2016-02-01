require 'pry'

task :get_kazoo, [:ticker, :days_back] => :environment do |t, args|
  days_back = args[:days_back] || 150
  ticker = args[:ticker].upcase! || args[:ticker]
  end_date = (Date.today - days_back)
  result = HTTParty.get "https://www.quandl.com/api/v3/datasets/WIKI/#{ticker}.json?start_date=#{end_date}&api_key=#{Rails.application.secrets.quandl_key}"

  keys = result['dataset']['column_names'].map{|key| key.downcase}
  data = result['dataset']['data']
  days = data.map do |day|
    Hash[keys.zip(day)]
  end

  # if kazoo.watchable?
  #   p "KAZOO IS WATCHABLE"
  #   puts 'BOOYA!!! it is worthy'
  kazoo = Kazoo.find_by ticker_name: ticker
  kazoo ||= Kazoo.create! ticker_name: ticker
  kazoo.create_days(days)
  # kazoo.watchable = true
  data2 = data.to_s
  kazoo["data"] = data2 || "can't be NIL"
  kazoo.save

  kazoo.atr
  # kazoo.days.each{ |day| puts day.low }

  # days = days.map do |day|
  #   kazoo.days.create!(kazoo_id: kazoo.id, date: day['date'], open: day['open'], close: day['close'])
  # end


  #   # Buyable == bought for testing purposes
  #   if Kazoo.buyable?(data)
  #     kazoo.bought = true
  #     kazoo.when_bought = Datetime.now
  #   end
  # else
  #   puts "not worthy!"
end

