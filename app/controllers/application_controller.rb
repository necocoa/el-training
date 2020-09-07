class ApplicationController < ActionController::Base
  helper_method :current_user
  before_action :login_required

  unless Rails.env.development?
    rescue_from Exception,                                      with: :render_500
    rescue_from StandardError,                                  with: :render_500
    rescue_from ActiveRecord::RecordNotFound,                   with: :render_404
    rescue_from ActionController::RoutingError,                 with: :render_404
    rescue_from Admin::AdminController::NotAuthorizedError,     with: :render_403
  end

  def routing_error
    raise ActionController::RoutingError, params[:path]
  end

  def render_403(exception = nil)
    logger.info "Rendering 403 with exception: #{exception.message}" if exception
    render 'errors/error_403', status: :forbidden
  end

  def render_404(exception = nil)
    logger.info "Rendering 404 with exception: #{exception.message}" if exception
    render 'errors/error_404', status: :not_found
  end

  def render_500(exception = nil)
    logger.info "Rendering 500 with exception: #{exception.message}" if exception
    render 'errors/error_500', status: :internal_server_error
  end

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def login_required
    redirect_to login_path unless current_user
  end
end
