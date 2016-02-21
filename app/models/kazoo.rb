class Kazoo < ActiveRecord::Base
  has_many :days
  has_many :holdings
  has_many :equity_accounts, through: :holdings

  def create_days(days)
    days.reverse.each do |day|
      self.days.create!(day.extract!('date', 'open', 'close', 'low', 'high'))
    end
  end

  def atr(count=15)
    days[0].update(atr: days[1..count].map{|day| day.high - day.low }.reduce{ |sum, cur| sum + cur } / count)
  end

  def smas
    recent_days(50).each do |day|
      day.sma = day_50_closes(days_between(day.date - 50.days, day.date))
      day.save!
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

  def recent_days(count)
    days_between(DateTime.now - count, DateTime.now)
  end

  def latest_day
    days.last
  end

end
