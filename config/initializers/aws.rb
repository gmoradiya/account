require "aws-sdk-s3"

Aws.config.update(
  region: "blr1", # Replace with your DigitalOcean Spaces region
  credentials: Aws::Credentials.new(Rails.application.credentials.dig(:digitalocean, :access_key), Rails.application.credentials.dig(:digitalocean, :secret)),
  endpoint: "https://aastha.blr1.digitaloceanspaces.com", # Update with your region's endpoint
  force_path_style: true,
  ssl_verify_peer: false # TEMPORARY FIX, NOT RECOMMENDED FOR PRODUCTION
)
