require "right_aws"

class BucketsController < ApplicationController

  def index
    @account = params[:account]
    @buckets = get_s3.list_all_my_buckets.collect {|bucket| bucket[:name]}
  end

  def list
    @account = params[:account]
    @bucket = params[:bucket]
    @prefix = params[:prefix]
    @prefixes = []
    @objects = []

    uri = env['REQUEST_URI'].to_s
    prefix = uri.end_with?('/') ? "#{params[:prefix]}/" : "#{params[:prefix]}"

    begin
      get_s3.incrementally_list_bucket(@bucket, {'prefix' => prefix, 'delimiter' => '/'}) do |bucket|
        bucket[:common_prefixes].each { |prefix|
          @prefixes << prefix
        }

        bucket[:contents].each { |object|
          @objects << object
        }
      end
    rescue RightAws::AwsError => e
      logger.error "Caught AWS error: #{e}"
      if e.http_code == "404"
        raise NotFoundError.new
      end
    end
  end

end
