# env :PATH, ENV['PATH']
set :output, "log/cron.log"

# every '0 0 1 * *' do
# every 1.day, at: '05:29 pm' do
every :hour do
  runner 'MonthlyViewCountUpdateJob.perform_now'
end