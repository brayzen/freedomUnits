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
# job_type :get_holding, '~/brayzen/rubyonrails/freedomUnits rake get_holding[":task"]'

every :day, :at => '2:05am' do
  search_list = ['amzn', 'aapl', 'msft', 'goog', 'wfc']
  search_list.each do |holding|
    holding.upcase!.to_s
    puts "its been 2 minutes and the holding is: #{holding}"
    rake "get_holding[#{holding}]"
  end
end
