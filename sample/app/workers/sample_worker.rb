class SampleWorker
  include Sidekiq::Worker
  sidekiq_options retry: 10

  def perform(arg, *options)
    puts "retry count"
    puts options
    raise 'to_retry'
  end
end