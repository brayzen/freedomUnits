class Kazoo < ActiveRecord::Base
  has_many :days

  def create_days(days)
    days.each do |day|
      self.days.create!(day.extract!('date', 'close'))
    end
  end

  def smas
    days = days_between(DateTime.now - 50.days, DateTime.now)
    days.each do |day|
      day.sma = day_50_closes(days_between(day.date - 50.days, day.date))
    end
  end

  def day_50_closes(days)
    days.map{|day| day.close}.inject(:+) / days.count
  end

  def days_between(start_date, end_date)
    days.where(date: start_date..end_date)
  end

  def sma_pass?(days=50)
    days_between(DateTime.now - 50.days, DateTime.now).each do |day|
      return false if day.sma > day.close
    end
    true
  end

end
