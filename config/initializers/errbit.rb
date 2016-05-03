if defined? Airbrake
  Airbrake.configure do |config|
    config.host = ENV['ERRBIT_HOST']
    config.project_id = true
    config.project_key = ENV['ERRBIT_KEY']
  end if ENV['ERRBIT_HOST'].present? and ENV['ERRBIT_KEY'].present?
end
