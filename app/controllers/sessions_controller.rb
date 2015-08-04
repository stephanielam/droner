class SessionsController < ApplicationController
  before_action :authenticate, only: [:destroy]
  def new
  end

  def create
    client = Client.find_by(username: params[:username])

    if client && client.authenticate(params[:password])
      session[:client_id] = client.id
      redirect_to drones_path, notice: "Welcome back, #{client.username}!"
    else
      flash.now[:alert] = "Log in failed..."
      render :new
    end
    
  end

  def destroy
    session[:client_id] = nil
    redirect_to new_session_path
  end

  def preview
    if session[:admin_id].nil?
      user_id = params[:id]
      session[:admin_id] = session[:client_id]
      session[:client_id] = user_id
      flash[:notice] = "Previewing as #{Client.find(user_id).username}! Signed in as admin #{Client.find(session[:admin_id]).username}"
      redirect_to client_path(current_client)
    else
      session[:client_id] = session[:admin_id]
      session[:admin_id] = nil
      flash[:notice] = "Signed back in as admin #{Client.find(session[:client_id]).username}"
      redirect_to admin_clients_path
    end
  end

end
