require 'pry'
class RentalsController < ApplicationController

  def index
    @rentals = Client.find(params[:client_id]).rentals
  end

  def new
    @drone = Drone.find(params[:drone_id])
    @rental = @drone.rentals.build
  end

  def create
    @rental = Rental.create(rental_params)
    redirect_to client(params[:client_id])
  end
  
  def show
    @rental = Rental.find(params[:id]) 
  end

  def edit
    @drone = Drone.find(params[:drone_id])
    @rental = Rental.find(params[:id])
  end

  def update
    @rental = Rental.find(params[:id])
    @rental.checkin = DateTime.now if !@rental.checkin 
    @rental.update(rental_params)
    if @rental.save
      flash[:alert] = "Saved review"
    else
      flash[:alert] = "Could not save review"
    end
    redirect_to client_path(current_client)
  end

  private

  def rental_params
    params.require(:rental).permit(:client_id, :drone_id, :checkin, :checkout, :review)
  end



end
