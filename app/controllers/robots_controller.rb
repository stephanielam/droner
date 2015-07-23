class RobotsController < ApplicationController
  before_action :authenticate, only: [:rent]
  before_filter :authorized, only: [:new, :create]

  def index
    @robots = Robot.all
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

  def rent
    @robot = Robot.find(params[:id])
    @robot.rentals.create(client: current_client, checkout: DateTime.now)
    flash[:notice] = "You have just rented #{@robot.name}!"
    redirect_to client_path(current_client)
  end

  def search
    @results = Robot.search(params[:search])
  end

  private

  def robot_params
    params.require(:robot).permit(:name, :model, :price, :rentals, :image, :remote_image_url, :search)
  end

end