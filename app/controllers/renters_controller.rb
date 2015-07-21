class ClientsController < ApplicationController

  def index
    @clients = Client.all
  end

  def new
    @rental = Client.new
  end

  def create
    @rental = Client.create(rental_params)
    redirect_to clients_path
  end

  def destroy
    @rental = Client.find(params[:id])
    @rental.destroy
    flash[:success] = "Your robo was terminated."
    redirect_to clients_path
  end

  def edit
    @rental = Client.find(params[:id])
  end

  def update
    @rental = Client.find(params[:id])
    @rental.update(rental_params)
    redirect_to clients_path
  end
  
  def show
    @rental = Client.find(params[:id]) 
  end

  private

  def rental_params
    params.require(:rental).permit(:username, :password)
  end
end
