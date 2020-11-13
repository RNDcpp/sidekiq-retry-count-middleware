module MyMiddleware
  class RetryCount
    def call(worker, msg, queue)
      msg['args'] << { retry_count: msg['retry_count']} if msg['access_retry_count']
      yield
    end
  end
end