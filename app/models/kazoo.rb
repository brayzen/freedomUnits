class Kazoo < ActiveRecord::Base
  has_many :days

  def self.sma(data, start_date=0, end_date=50)
    puts = data
    collection = data.slice(start_date.to_i, end_date.to_i).map{ |day| day[4] }
    @sma50 = collection.reduce{ |memo, cur| memo + cur } / collection.length
  end

  def self.sma_cleared(data, avg=50, days=50)
    start_date, end_date = 1, 1 + days
    close = data[0][4]
    array_of_smas = []
    avg.times do
      sma = sma(data, start_date, end_date)
      return false if sma < close
      start_date += 1
      end_date += 1
    end
    return true
  end

  def self.watchable?(data)
    Kazoo.sma_cleared(data)
  end

  def self.buyable?(data)
    Kazoo.sma(data, 0, 50) < data[0][4]
  end

  def get_close
    @data["dataset_data"]["data"][0][4]
  end

  def selling_point
  end

  def invest_point
  end

end
