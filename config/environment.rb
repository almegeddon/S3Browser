# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
S3::Application.initialize!

accounts = Hash.new
config = YAML.load_file("#{Rails.root}/config/s3.yml")
config.each do |account|
  accounts[account[0].to_s] = RightAws::S3Interface.new(account[1]['aws_access_key_id'], account[1]['aws_secret_access_key'], { :multi_thread => true })
end
S3::Application.config.accounts = accounts
