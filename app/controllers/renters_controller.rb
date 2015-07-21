class RentersController < ApplicationController
  def index
    @renters = Renter.all
  end

  def new
    @rental = Renter.new
  end

  def create
    @rental = Renter.create(rental_params)
    redirect_to renters_path
  end

  def destroy
    @rental = Renter.find(params[:id])
    @rental.destroy
    flash[:success] = "Your robo was terminated."
    redirect_to renters_path
  end

  def edit
    @rental = Renter.find(params[:id])
  end

  def update
    @rental = Renter.find(params[:id])
    @rental.update(rental_params)
    redirect_to renters_path
  end
  
  def show
    @rental = Renter.find(params[:id]) 
  end

  private

  def rental_params
    params.require(:rental).permit(:username, :password)
  end
end
