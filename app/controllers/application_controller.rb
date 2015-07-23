class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  def authenticate
    if !current_client
      flash[:alert] = "You must log in."
      redirect_to new_session_path
    end
  end

  def authorized
    if !current_client.admin
      flash[:alert] = "You must be an admin to view this page."
      redirect_to robots_path
    end
  end

  def current_client
    @current_client ||= Client.find(session[:client_id]) if session[:client_id]
  end

  helper_method :current_client

end
