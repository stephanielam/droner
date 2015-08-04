require 'pry'
class DronesController < ApplicationController
  before_action :authenticate, only: [:rent]
  before_filter :authorized, only: [:new, :create]

  def index
    @drones = Drone.all
    @rentals = Rental.all
  end

  def new
    @drone = Drone.new
  end

  def create
    @drone = Drone.create(drone_params)
    redirect_to drones_path
  end

  def destroy
    @drone = Drone.find(params[:id])
    @drone.destroy
    flash[:success] = "Your robo was terminated."
    redirect_to drones_path
  end

  def edit
    @drone = Drone.find(params[:id])
  end

  def update
    @drone = Drone.find(params[:id])
    @drone.update(drone_params)
    # TODO: should update with uploaded image, not url if both supplied
    if (params[:drone][:image] && params[:drone][:remote_image_url])
      @drone.update(image: params[:drone][:image])
    end
    redirect_to drones_path
  end
  
  def show
    @drone = Drone.find(params[:id]) 
  end

  def available?
    # check all rentals of drone have checkin dates
    @drone = Drone.find(params[:id])
    @drone.rentals.each do |rental|
      return false if (rental.checkin == nil)
    end
    true
  end

  def rent
    @drone = Drone.find(params[:id])
    if available?
      @drone.rentals.create(client: current_client, checkout: DateTime.now)
      flash[:notice] = "You have just rented #{@drone.name}!"
      redirect_to client_path(current_client)
    else 
      flash[:notice] = "#{@drone.name} is not available!"
      redirect_to drones_path
    end
  end

  def search
    flash[:alert] = "You searched."
    @drones = Drone.search(params[:searchKey])
    case params[:price]
    when "0"
    when "1"
      @drones = @drones.price_less_than(100)
    when "2"
      @drones = @drones.price_greater_than(100).price_less_than(500)
    when "3"
      @drones = @drones.price_greater_than(500)
    end 
    @drones
  end

  private

  def drone_params
    params.require(:drone).permit(:name, :model, :price, :rentals, :image, :remote_image_url, :searchKey, :price)
  end

end