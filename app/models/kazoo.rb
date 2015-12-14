class Kazoo < ActiveRecord::Base
  has_many :days

  def sma(data, start_date=0, end_date=50)
    collection = data["dataset_data"]["data"].slice(start_date.to_i, end_date.to_i).map{ |day| day[4] }
    @sma50 = collection.reduce{ |memo, cur| memo + cur } / collection.length
  end

  def sma_cleared(avg=50, days=50)
    start_date, end_date = 1, 1 + days
    array_of_smas = []
    avg.times do
      sma = find_SMA(data, start_date, end_date)
      return false if sma < @close
      start_date += 1
      end_date += 1
    end
    return true
  end

  def get_close
    @data["dataset_data"]["data"][0][4]
  end

  def selling_point
  end

  def invest_point
  end

end
