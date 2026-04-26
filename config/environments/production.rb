# frozen_string_literal: true

require 'active_support/core_ext/integer/time'

Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.public_file_server.headers = { 'Cache-Control' => "public, max-age=#{1.year.to_i}" }
  config.active_storage.service = :local
  config.force_ssl = true
  config.log_tags = [:request_id]
  config.logger = ActiveSupport::Logger.new($stdout)
  config.active_support.report_deprecations = false
  config.active_record.dump_schema_after_migration = false
end
