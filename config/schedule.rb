# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever
# search_list.each { |holding| get_stock(holding) }
require "active_record"
require 'date'


every :day, :at => '1:59pm' do
  # if 1 < Date.today.wday && Date.today.wday < 7
    # ActiveRecord::Base.connection.execute('DELETE * FROM days')
    # search_list = ['amzn', 'aapl', 'msft', 'goog', 'wfc', 'EXPE']
    search_list = ['hd', 'c', 'unh', 'hpq', 'ibm', 'bac', 'amzn', 'aapl', 'msft', 'goog', 'wfc', 'EXPE']
    search_list.each do |holding|
      holding.upcase!.to_s
      rake "get_holding[#{holding}]"
    end
  # end
end

# every :day, :at => '12:37pm' do
#   if 1 < Date.today.wday && Date.today.wday < 7
#     # ActiveRecord::Base.connection.execute('DELETE * FROM days')
#     search_list = ['amzn', 'aapl', 'msft', 'goog', 'wfc', 'EXPE']
#     search_list.each do |holding|
#       holding.upcase!.to_s
#       rake "get_holding[#{holding}]"
#     end
#   end
# end
