class AccountsController < ApplicationController
  def index
    @accounts = S3::Application.config.accounts.keys
  end
end
