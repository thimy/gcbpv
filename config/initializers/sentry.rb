Sentry.init do |config|
  config.dsn = 'https://a0aa628c59dc5de25f5bc6b0dde5759c@o4509706902962176.ingest.de.sentry.io/4509706904600656'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Add data like request headers and IP for users,
  # see https://docs.sentry.io/platforms/ruby/data-management/data-collected/ for more info
  config.send_default_pii = true
  config.enabled_environments = %w[production]
end
