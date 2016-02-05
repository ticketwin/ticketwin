Apipie.configure do |config|
  config.app_name                = "Ticketwin"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/api"
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/api/**/*.rb"
end
