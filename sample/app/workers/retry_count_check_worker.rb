class RetryCountCheckWorker
  include Sidekiq::Worker
  sidekiq_options retry: 10
  sidekiq_options access_retry_count: true

  def perform(arg, *options)
    puts "retry count"
    puts options
    raise 'to_retry'
  end
end