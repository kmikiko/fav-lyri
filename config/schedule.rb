set :path_env, ENV['PATH']
set :output, "log/cron.log"
job_type :runner, "cd :path && PATH=':path_env' bin/rails runner -e :environment ':task' :output"

# every '0 0 1 * *' do
every 1.day, at: '00:00 am' do
# every :hour do
  runner 'MonthlyViewCountUpdateJob.perform_now'
end