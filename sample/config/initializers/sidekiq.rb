require File.expand_path('../../my_middleware/retry_count.rb', File.dirname(__FILE__))

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://redis:6379' }
  config.server_middleware do |chain|
    chain.add MyMiddleware::RetryCount
  end
end
Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://redis:6379' }
end