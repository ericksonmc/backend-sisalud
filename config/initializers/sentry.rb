Sentry.init do |config|
  config.dsn = 'https://33386201382c47c0a4d4ba193d8936b5@o423517.ingest.sentry.io/5933185'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Set tracesSampleRate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production
  config.traces_sample_rate = 0.5
  # or
  config.traces_sampler = lambda do |context|
    true
  end
end