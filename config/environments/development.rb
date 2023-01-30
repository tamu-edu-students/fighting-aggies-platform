# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  config.action_mailer.delivery_method = :test # change to smtp to send emails
  config.action_mailer.default_url_options = { host: 'localhost:8080', protocol: 'http' }
  config.action_mailer.smtp_settings = {
    address: 'smtp.gmail.com',
    port: 587,
    user_name: 'fighting.aggies.analytics@gmail.com',
    password: 'tsaqzyyqbplvzcaa',
    authentication: 'plain',
    enable_starttls_auto: true
  }

  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = false
  # Configure 'rails notes' to inspect Cucumber files
  config.annotations.register_directories('features')
  config.annotations.register_extensions('feature') { |tag| /#\s*(#{tag}):?\s*(.*)$/ }

  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded any time
  # it changes. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable server timing
  config.server_timing = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join('tmp/caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local
  # config.active_storage.service = :amazon

  # Don't care if the mailer can't send.
  # config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  config.hosts << 'f0ab0606648b43769bddc0f4b5d734f3.vfs.cloud9.us-east-2.amazonaws.com'

  config.hosts << '3bd605c3f5cc4c4d8558806a2c799593.vfs.cloud9.us-east-2.amazonaws.com'

  config.hosts << '49fef5f7dfa4451eb83c853d80999ec4.vfs.cloud9.us-east-2.amazonaws.com'

  config.hosts << 'f01a7c74ddb749f6b723649d2d62c6f3.vfs.cloud9.us-east-2.amazonaws.com'

  config.hosts << '87304fe082084245acb3c50ba6a71fee.vfs.cloud9.us-east-2.amazonaws.com'

  config.hosts << 'd26692b39ceb4d4495dbc14c56f8fd6e.vfs.cloud9.us-east-2.amazonaws.com'

  config.web_console.permissions = ['50.24.124.59', '128.194.2.169', '50.24.40.10']

  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true
end
