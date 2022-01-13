# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Backend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    config.api_only = true

    config.active_record.default_timezone = :local
    config.active_record.time_zone_aware_attributes = false
    config.i18n.fallbacks = true
    config.action_cable.mount_path = '/cable'

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    config.active_job.queue_adapter = :sidekiq

    config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*',
          headers: :any,
          methods: %i[get post options put delete],
          expose: ['Content-Disposition']
      end
    end
  end
end
