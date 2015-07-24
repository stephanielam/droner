class ClientsController < ApplicationController
  before_filter :authorized, only: [:index]
  
  def index
    @clients = Client.all
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      session[:client_id] = @client.id # auto log in
      redirect_to clients_path, notice: "Welcome, #{@client.username}!"
    else
      render :new
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    flash[:success] = "Client was terminated."
    redirect_to clients_path
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    @client.update(client_params)
    redirect_to robots_path
  end
  
  def show
    @client = Client.find(params[:id]) 
  end

  protected

  def client_params
    params.require(:client).permit(:username, :password, :password_confirmation, :admin)
  end


end
