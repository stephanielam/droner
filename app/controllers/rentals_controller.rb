class RentalsController < ApplicationController

  def index
    @rentals = Client.find(params[:client_id]).rentals
  end

  def new
    @robot = Robot.find(params[:robot_id])
    @rental = @robot.rentals.build
  end

  def create
    @rental = Rental.create(rental_params)
    redirect_to client(params[:client_id])
  end
  
  def show
    @rental = Rental.find(params[:id]) 
  end

  def edit
    @rental = Rental.find(params[:id])
    @robot = Robot.find(params[:robot_id])
  end

  def update
    @rental = Rental.find(params[:id])
    @rental.checkin = DateTime.now if !@rental.checkin 
    @rental.update(rental_params)
    redirect_to client_path(current_client)
  end

  private

  def rental_params
    params.require(:rental).permit(:client_id, :robot_id, :checkin, :checkout)
  end



end
