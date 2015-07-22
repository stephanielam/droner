class SessionsController < ApplicationController
  before_action :authenticate, only: [:destroy]
  def new
  end

  def create
    client = Client.find_by(username: params[:username])

    if client && client.authenticate(params[:password])
      session[:client_id] = client.id
      redirect_to robots_path, notice: "Welcome back, #{client.username}!"
    else
      flash.now[:alert] = "Log in failed..."
      render :new
    end
  end

  def destroy
    session[:client_id] = nil
    redirect_to new_session_path, notice: "Adios!"
  end

end
