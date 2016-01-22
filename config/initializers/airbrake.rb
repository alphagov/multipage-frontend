if ENV['ERRBIT_API_KEY'].present?
  Airbrake.configure do |config|
    config.api_key = ENV['ERRBIT_API_KEY']
    config.host = "errbit.#{ENV['GOVUK_APP_DOMAIN']}"
    config.secure = errbit_uri.scheme == 'https'
    config.environment_name = ENV['ERRBIT_ENVIRONMENT_NAME']
  end
end
