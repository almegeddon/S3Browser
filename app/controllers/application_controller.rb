class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from NotFoundError, :with => :render_404

  def render_404(exception = nil)
    if exception
      logger.info "Rendering 404 with exception: #{exception.message}"
    end

    respond_to do |format|
      format.html { render :file => "#{Rails.root}/public/404.html", :status => :not_found }
      format.xml  { head :not_found }
      format.any  { head :not_found }
    end
  end

  def get_s3
    s3 = S3::Application.config.accounts[params[:account]]
    if s3.nil?
      raise NotFoundError.new
    end

    s3
  end

end
