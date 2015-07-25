require 'pry'
class RobotsController < ApplicationController
  before_action :authenticate, only: [:rent]
  before_filter :authorized, only: [:new, :create]

  def index
    @robots = Robot.all
    @rentals = Rental.all
  end

  def new
    @robot = Robot.new
  end

  def create
    @robot = Robot.create(robot_params)
    redirect_to robots_path
  end

  def destroy
    @robot = Robot.find(params[:id])
    @robot.destroy
    flash[:success] = "Your robo was terminated."
    redirect_to robots_path
  end

  def edit
    @robot = Robot.find(params[:id])
  end

  def update
    @robot = Robot.find(params[:id])
    @robot.update(robot_params)
    # TODO: should update with uploaded image, not url if both supplied
    if (params[:robot][:image] && params[:robot][:remote_image_url])
      @robot.update(image: params[:robot][:image])
    end
    redirect_to robots_path
  end
  
  def show
    @robot = Robot.find(params[:id]) 
  end

  def available?
    # check all rentals of robot have checkin dates
    @robot = Robot.find(params[:id])
    @robot.rentals.each do |rental|
      return false if (rental.checkin == nil)
    end
    true
  end

  def rent
    @robot = Robot.find(params[:id])
    if available?
      @robot.rentals.create(client: current_client, checkout: DateTime.now)
      flash[:notice] = "You have just rented #{@robot.name}!"
      redirect_to client_path(current_client)
    else 
      flash[:notice] = "#{@robot.name} is not available!"
      redirect_to robots_path
    end
  end

  def search
    flash[:alert] = "You searched."
    @robots = Robot.search(params[:searchKey])
    case params[:price]
    when "0"
    when "1"
      @robots = @robots.price_less_than(100)
    when "2"
      @robots = @robots.price_greater_than(100).price_less_than(500)
    when "3"
      @robots = @robots.price_greater_than(500)
    end 
    @robots
  end

  private

  def robot_params
    params.require(:robot).permit(:name, :model, :price, :rentals, :image, :remote_image_url, :searchKey, :price)
  end

end