CarrierWave.configure do |config|
  if Rails.env.production?
    config.fog_credentials = {
      provider:              AppConfig.s3.provider,
      aws_access_key_id:     AppConfig.s3.access_key_id,
      aws_secret_access_key: AppConfig.s3.secret_access_key,
    }

    config.storage = :fog
    config.fog_directory = AppConfig.s3.bucket
    config.force_use_ssl_for_aws = true
  else
    config.storage = :file
    config.enable_processing = false
    config.root = "#{Rails.root}/tmp"
  end

  config.cache_dir = "#{Rails.root}/tmp/uploads"

end
