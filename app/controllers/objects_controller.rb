class ObjectsController < ApplicationController

  def show
    redirect_to get_s3.get_link params[:bucket], params[:key]
  end

end
