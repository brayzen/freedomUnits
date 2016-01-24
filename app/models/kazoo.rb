class Kazoo < ActiveRecord::Base
  has_many :days

  def initialize(days)
    super()
    days.each do |day|
      self.days.build day.extract!('date', 'close')
    end
  end

  def sma(days)
    closings = days.map{ |day| day.close.to_i }
    @sma50 = closings.inject(:+) / closings.length
  end

  # def self.sma_cleared(data, avg=50, days=50)
  #   start_date, end_date = 1, 1 + days
  #   last_close = data[0][4]
  #   array_of_smas = []
  #   avg.times do
  #     sma = sma(data, start_date, end_date)
  #     day_closing = close(data, start_date)
  #     # puts "^^^ #{sma} ^^^: sma VS. *** #{last_close} ***: close.....close should be higher"
  #     return false if sma < last_close || sma < day_closing
  #     # puts "#{start_date} = start date"
  #     # puts "#{end_date} = end date"
  #     start_date += 1
  #     end_date += 1
  #   end
  #   return true
  # end

  def sma_cleared(count=50)
    test_days = days.last count
    test_days.each_with_index do |day, index|
      current_sma = sma test_days.slice(index..- 1)
      puts "#{current_sma} : current SMA"
      # current_sma = sma test_days.slice index..-1
      return false if current_sma < days.last["close"].to_i || current_sma < day["close"].to_i
    end

    true
  end


  def self.crossed?(data, start_date)
    data[0][4] > sma(data)
  end

  def watchable?
    sma_cleared
  end

  def self.buyable?(data)
    Kazoo.sma(data, 0, 50) < data[0][4]
  end

  # def self.close(data, start_date)
  #   data[start_date][4]
  # end


  def selling_point
  end

  def invest_point
  end

end
