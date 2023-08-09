set :path_env, ENV['PATH']
set :output, "log/cron.log"
job_type :runner, "cd :path && PATH=':path_env' bin/rails runner -e :environment ':task' :output"

every 1.day, at: '00:00 am' do
  runner 'MonthlyViewCountUpdateJob.perform_now'
end