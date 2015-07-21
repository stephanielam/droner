class RentalsController < ApplicationController
  def index
    @rentals = Rental.all
  end

  def new
    @rental = Rental.new
  end

  def create
    @rental = Rental.create(rental_params)
    redirect_to rentals_path
  end
  
  def show
    @rental = Rental.find(params[:id]) 
  end

  private

  def rental_params
    params.require(:rental).permit(:renter_id, :robot_id, :checkin, :checkout)
  end
end
