## Usage
```sidekiq.rb
# initializers/sidekiq.rb

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
```

```retry_count_check_worker.rb
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
```

### result

```
2020-11-13T16:36:12.598Z pid=245 tid=gnibh9mf5 class=RetryCountCheckWorker jid=a98aef99e7f4a3e73b2a43d9 INFO: start
retry count
hoge
{:retry_count=>nil}

...

2020-11-13T16:36:35.752Z pid=245 tid=gnibh9lah class=RetryCountCheckWorker jid=a98aef99e7f4a3e73b2a43d9 INFO: start
retry count
hoge
{:retry_count=>0}

...

2020-11-13T16:37:46.993Z pid=245 tid=ovdu6o4h1 class=RetryCountCheckWorker jid=a98aef99e7f4a3e73b2a43d9 INFO: start
retry count
hoge
{:retry_count=>1}
```