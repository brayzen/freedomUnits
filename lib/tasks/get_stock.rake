
# desc "gathering info about a stock"
task :get_stock, [:stock] => :environment do |t, args|
  stock = args[:stock]
  print "Getting #{stock} from Quandl"

  result = HTTParty.get "https://www.quandl.com/api/v3/datasets/WIKI/#{stock}.json"

  keys = result['dataset']['column_names']
  data = result['dataset']['data']

  days = data.map do |day|
    Hash[day.map.with_index do |datum, index|
      [keys[index], datum]
    end]
  end
end


