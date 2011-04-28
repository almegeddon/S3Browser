require 'test_helper'

class AccountsControllerTest < ActionController::TestCase

  test "the s3 config" do
    S3::Application.config.accounts.keys.each do |account|
      puts account
    end
  end
end
