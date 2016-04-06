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

# 03 * * * * cd /Desktop/gary/MagicMic && /Users/apprentice/.rbenv/shims/rake exec rake reminders:text

# every '03 * * * *' do
#   command "rake 'reminders:text'"
# end

# 00 09 * * *  9AM every day

# 00 * * * * every hour on the hour

every 1.day do
  rake "reminders:daily"
end

every 1.hour do
  rake "reminders:hourly"
end

every :sunday, :at => '9am' do
  rake "reminders:daily"
end

every :hour do
  rake "reminders:hourly"
end

every 30.minutes do
  rake "reminders:hourly"
end

every '10 * * * *' do
  rake 'reminders:hourly'
end

every :wednesday, :at => '3:11pm' do
  rake "reminders:hourly"
  rake "reminders:daily"
end
